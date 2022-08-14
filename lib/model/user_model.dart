import 'package:insta_clone/import.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List following;
  final List follower;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.follower,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "follower": follower,
        "following": following
      };

  static User fromsnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return User(
        email: data['email'],
        uid: data['uid'],
        photoUrl: data['photoUrl'],
        username: data['username'],
        bio: data['bio'],
        follower: data['follower'],
        following: data['following']);
  }
}
