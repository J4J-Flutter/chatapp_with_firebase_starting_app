class ChatMessageModel {
  final String message;
  final String sender;
  final DateTime time;

  const ChatMessageModel(
      {required this.message, required this.sender, required this.time});
}
