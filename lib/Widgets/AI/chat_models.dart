class ChatProposal {
  final String deepFocusLabel;
  final String deepFocusTime;
  final String rescheduleLabel;
  final String rescheduleAction;
  final String question;

  const ChatProposal({
    required this.deepFocusLabel,
    required this.deepFocusTime,
    required this.rescheduleLabel,
    required this.rescheduleAction,
    required this.question,
  });
}

class ChatMessage {
  final bool isUser;
  final String text;
  final String time;
  final ChatProposal? proposal;

  const ChatMessage({
    required this.isUser,
    required this.text,
    required this.time,
    this.proposal,
  });
}
