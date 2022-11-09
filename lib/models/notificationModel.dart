import 'dart:convert';

class Notifications {
  int id;
  String title;
  String body;
  bool isSeen = false;
  String date;
  String time;
  String userName;

  String userImage;
  Notifications({
    this.id,
    this.title,
    this.body,
    this.isSeen,
    this.date,
    this.time,
    this.userName,
    this.userImage,
  });

  Notifications copyWith({
    int id,
    String title,
    String body,
    bool isSeen,
    String date,
    String time,
    String userName,
    String userImage,
  }) {
    return Notifications(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isSeen: isSeen ?? this.isSeen,
      date: date ?? this.date,
      time: time ?? this.time,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'body': body});
    result.addAll({'isSeen': isSeen});
    result.addAll({'date': date});
    result.addAll({'time': time});
    result.addAll({'userName': userName});
    result.addAll({'userImage': userImage});

    return result;
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      isSeen: map['isSeen'] ?? false,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notifications(id: $id, title: $title, body: $body, isSeen: $isSeen, date: $date, time: $time, userName: $userName, userImage: $userImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notifications &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.isSeen == isSeen &&
        other.date == date &&
        other.time == time &&
        other.userName == userName &&
        other.userImage == userImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        isSeen.hashCode ^
        date.hashCode ^
        time.hashCode ^
        userName.hashCode ^
        userImage.hashCode;
  }

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
}
