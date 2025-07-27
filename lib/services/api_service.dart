import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";
  static const String _apiKey = "AIzaSyCgpEfbi941v4Rf21E9yxlVkqZDa3Ni6rE";
  static Future<String> getChatGPTResponse(String userInput) async {
    int retryCount = 0;
    const int maxRetries = 3;
    int retryDelay = 5; // Start with a 5-second delay

    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(_baseUrl), // This should be the Gemini URL
          headers: {
            "Content-Type": "application/json",
            "X-goog-api-key":
                _apiKey, // Changed from Authorization Bearer to X-goog-api-key
          },
          body: jsonEncode({
            "contents": [
              // Changed from "messages" to "contents"
              {
                "parts": [
                  // Changed structure to match Gemini format
                  {
                    "text":
                        "dont talk like a chatbot, talk like astrologer human being as You are a professional astrologer with expertise in Western astrology, Vedic astrology, and tarot. Provide detailed astrological insights for limit your words to 100 " +
                            userInput
                  }
                ]
              }
            ]
            // Removed model and max_tokens as they're not needed for Gemini
          }),
        );

        log("Response: ${response.body}");
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // ✅ Correct Gemini parsing format
          return data['candidates'][0]['content']['parts'][0]['text'].trim();
        } else if (response.statusCode == 429) {
          retryCount++;
          if (retryCount < maxRetries) {
            print("Rate limit exceeded. Retrying in $retryDelay seconds...");
            await Future.delayed(Duration(seconds: retryDelay));
            retryDelay *= 2; // Exponential backoff
          } else {
            return "Error: Rate limit exceeded. Please try again later.";
          }
        } else {
          return "Error: ${response.reasonPhrase} (Code: ${response.statusCode})";
        }
      } catch (e) {
        return "Error: Unable to connect to Gemini. Exception: $e";
      }
    }
    return "Error: Unable to get response after multiple retries.";
  }

  // static Future<String> getChatGPTResponse(String userInput) async {
  //   int retryCount = 0;
  //   const int maxRetries = 3;
  //   const int retryDelay = 5;
  //   while (retryCount < maxRetries) {
  //     try {
  //       final response = await http.post(
  //         Uri.parse(_baseUrl),
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer $_apiKey",
  //         },
  //         body: jsonEncode({
  //           "model": "gpt-3.5-turbo",
  //           "messages": [
  //             {"role": "user", "content": userInput}
  //           ],
  //           "max_tokens": 150,
  //         }),
  //       );
  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         return data['choices'][0]['message']['content'].trim();
  //       } else if (response.statusCode == 429) {
  //         retryCount++;
  //         if (retryCount < maxRetries) {
  //           await Future.delayed(Duration(seconds: retryDelay));
  //         } else {
  //           return "Error: Rate limit exceeded. Please try again later.";
  //         }
  //       } else {
  //         return "Error: ${response.reasonPhrase} (Code: ${response.statusCode})";
  //       }
  //     } catch (e) {
  //       return "Error: Unable to connect to ChatGPT. Exception: $e";
  //     }
  //   }
  //   return "Error: Unable to get response after multiple retries.";
  // }
}
