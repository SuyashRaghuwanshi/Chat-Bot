import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "https://api.openai.com/v1/chat/completions";
  static const String _apiKey = "use your api";
  static Future<String> getChatGPTResponse(String userInput) async {
    int retryCount = 0;
    const int maxRetries = 3;
    const int retryDelay = 5;
    while (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(_baseUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $_apiKey",
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": userInput}
            ],
            "max_tokens": 150,
          }),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['choices'][0]['message']['content'].trim();
        } else if (response.statusCode == 429) {
          retryCount++;
          if (retryCount < maxRetries) {
            await Future.delayed(Duration(seconds: retryDelay));
          } else {
            return "Error: Rate limit exceeded. Please try again later.";
          }
        } else {
          return "Error: ${response.reasonPhrase} (Code: ${response.statusCode})";
        }
      } catch (e) {
        return "Error: Unable to connect to ChatGPT. Exception: $e";
      }
    }
    return "Error: Unable to get response after multiple retries.";
  }
}
