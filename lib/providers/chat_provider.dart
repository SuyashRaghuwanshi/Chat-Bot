import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for the chat messages
final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<Map<String, dynamic>>>(
  (ref) => ChatMessagesNotifier(),
);

// Define a provider for the typing status
final isTypingProvider = StateProvider<bool>((ref) => false);

// ChatMessagesNotifier class to manage the chat messages
class ChatMessagesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ChatMessagesNotifier() : super([]);

  void addMessage(Map<String, dynamic> message) {
    state = [...state, message];
  }
}
