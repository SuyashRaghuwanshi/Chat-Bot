import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helper/providers/chat_provider.dart'; // Import the provider file
import 'package:helper/services/api_service.dart'; // Import your API service class
import 'package:helper/widgets/chat_widget.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessages = ref.watch(chatMessagesProvider); // Watch chat messages
    final _isTyping = ref.watch(isTypingProvider); // Watch the typing state
    final controller = TextEditingController();

    Future<void> sendMessage(String userInput) async {
      // Add user input to chat messages
      ref
          .read(chatMessagesProvider.notifier)
          .addMessage({"msg": userInput, "chatIndex": 0});
      ref.read(isTypingProvider.notifier).state =
          true; // Set typing state to true

      try {
        // Call API to get the response
        String response = await ApiService.getChatGPTResponse(userInput);
        ref
            .read(chatMessagesProvider.notifier)
            .addMessage({"msg": response, "chatIndex": 1});
      } catch (e) {
        ref.read(chatMessagesProvider.notifier).addMessage(
            {"msg": "Error: Unable to get a response.", "chatIndex": 1});
      } finally {
        ref.read(isTypingProvider.notifier).state =
            false; // Set typing state to false
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 33, 52),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('HELPER'),
        actions: [
          IconButton(
            onPressed: () {
              // Add modal sheet or settings functionality
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.black),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat messages list
            Flexible(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatMessages[index]["msg"].toString(),
                    chatIndex: chatMessages[index]["chatIndex"],
                  );
                },
              ),
            ),
            // Typing indicator
            if (_isTyping)
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            // Input field and send button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.blue),
                      controller: controller,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          sendMessage(value);
                          controller.clear();
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "How can I help you",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        sendMessage(controller.text);
                        controller.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
