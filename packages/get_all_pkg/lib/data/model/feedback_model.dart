class FeedbackModel {
  String? id;
  String? createdAt;
  String? senderName;
  String? schoolId;
  String? message;
  bool? isRead;

  FeedbackModel(
      {this.id,
      this.createdAt,
      this.senderName,
      this.schoolId,
      this.message,
      this.isRead});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    createdAt = json["created_at"];
    senderName = json["sender_name"];
    schoolId = json["school_id"];
    message = json["message"];
    isRead = json["is_read"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["created_at"] = createdAt;
    _data["sender_name"] = senderName;
    _data["school_id"] = schoolId;
    _data["message"] = message;
    _data["is_read"] = isRead;
    return _data;
  }
}
