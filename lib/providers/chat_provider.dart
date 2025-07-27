import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<Map<String, dynamic>>>(
  (ref) => ChatMessagesNotifier(),
);

final isTypingProvider = StateProvider<bool>((ref) => false);

class ChatMessagesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ChatMessagesNotifier() : super([]);

  void addMessage(Map<String, dynamic> message) {
    state = [...state, message];
  }
}
