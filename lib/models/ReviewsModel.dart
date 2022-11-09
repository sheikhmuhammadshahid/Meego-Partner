import 'dart:convert';

class Review {
  int retingId;
  int userId;
  int vendorId;
  double ratingCount;
  String comment;
  String username;
  String userImage;
  String createdTime;
  Review(
    this.retingId,
    this.userId,
    this.vendorId,
    this.ratingCount,
    this.comment,
    this.username,
    this.userImage,
    this.createdTime,
  );

  Review copyWith({
    int retingId,
    int userId,
    int vendorId,
    double ratingCount,
    String comment,
    String username,
    String userImage,
    String createdTime,
  }) {
    return Review(
      retingId ?? this.retingId,
      userId ?? this.userId,
      vendorId ?? this.vendorId,
      ratingCount ?? this.ratingCount,
      comment ?? this.comment,
      username ?? this.username,
      userImage ?? this.userImage,
      createdTime ?? this.createdTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'retingId': retingId});
    result.addAll({'userId': userId});
    result.addAll({'vendorId': vendorId});
    result.addAll({'ratingCount': ratingCount});
    result.addAll({'comment': comment});
    result.addAll({'username': username});
    result.addAll({'userImage': userImage});
    result.addAll({'createdTime': createdTime});

    return result;
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      map['retingId']?.toInt() ?? 0,
      map['userId']?.toInt() ?? 0,
      map['vendorId']?.toInt() ?? 0,
      map['ratingCount']?.toDouble() ?? 0.0,
      map['comment'] ?? '',
      map['username'] ?? '',
      map['userImage'] ?? '',
      map['createdTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(retingId: $retingId, userId: $userId, vendorId: $vendorId, ratingCount: $ratingCount, comment: $comment, username: $username, userImage: $userImage, createdTime: $createdTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.retingId == retingId &&
        other.userId == userId &&
        other.vendorId == vendorId &&
        other.ratingCount == ratingCount &&
        other.comment == comment &&
        other.username == username &&
        other.userImage == userImage &&
        other.createdTime == createdTime;
  }

  @override
  int get hashCode {
    return retingId.hashCode ^
        userId.hashCode ^
        vendorId.hashCode ^
        ratingCount.hashCode ^
        comment.hashCode ^
        username.hashCode ^
        userImage.hashCode ^
        createdTime.hashCode;
  }
}
