import 'package:chatapp_with_firebase/components/chat_message_bubble.dart';
import 'package:chatapp_with_firebase/models/chat_message_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessageModel> messages = [
    ChatMessageModel(
      message: "Hello world",
      sender: "me",
      time: DateTime.now(),
    ),
    ChatMessageModel(
      message: "Hello J4J group",
      sender: "Bob",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessageModel(
      message: "Hello Bob",
      sender: "Alice",
      time: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
  ]..sort((a, b) => a.time.compareTo(b.time));

  void onSendPressed() {
    // print("Send pressed");
  }

  @override
  Widget build(BuildContext context) {
    const chatTitle = "J4J Flutter Chat";
    const sendBtnText = "Send";
    const textInputTextHint = "Write a message";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(chatTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatMessageBubble(message);
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: textInputTextHint,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onSendPressed,
                  icon: const Icon(Icons.send),
                  label: const Text(sendBtnText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
