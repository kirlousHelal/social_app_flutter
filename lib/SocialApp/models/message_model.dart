class MessageModel {
  String? message;
  String? dateTime;
  String? senderId;
  String? receiverId;

  MessageModel({
    required this.message,
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['receiverId'] = receiverId;
    data['dateTime'] = dateTime;
    data['senderId'] = senderId;

    return data;
  }
}
