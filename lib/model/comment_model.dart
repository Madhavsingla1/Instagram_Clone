// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comment {
  final String comments;
  final String postid;
  final String uid;
  final String profilePic;
  final String commentid;
  final DateTime datePublished;
  final String username;
  Comment({
    required this.comments,
    required this.postid,
    required this.uid,
    required this.profilePic,
    required this.commentid,
    required this.datePublished,
    required this.username,
  });

  Comment copyWith({
    String? comments,
    String? postid,
    String? uid,
    String? profilePic,
    String? commentid,
    DateTime? datePublished,
    String? username,
  }) {
    return Comment(
      comments: comments ?? this.comments,
      postid: postid ?? this.postid,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      commentid: commentid ?? this.commentid,
      datePublished: datePublished ?? this.datePublished,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comments': comments,
      'postid': postid,
      'uid': uid,
      'profilePic': profilePic,
      'commentid': commentid,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'username': username,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      comments: map['comments'] as String,
      postid: map['postid'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      commentid: map['commentid'] as String,
      datePublished:
          DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(comments: $comments, postid: $postid, uid: $uid, profilePic: $profilePic, commentid: $commentid, datePublished: $datePublished, username: $username)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;

    return other.comments == comments &&
        other.postid == postid &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.commentid == commentid &&
        other.datePublished == datePublished &&
        other.username == username;
  }

  @override
  int get hashCode {
    return comments.hashCode ^
        postid.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        commentid.hashCode ^
        datePublished.hashCode ^
        username.hashCode;
  }
}
