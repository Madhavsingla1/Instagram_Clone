import 'package:insta_clone/import.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final List likes;

  const Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.profImage,
    required this.postUrl,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "postId": postId,
        "description": description,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
      };

  static Post fromsnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    return Post(
      postId: data['postId'],
      uid: data['uid'],
      postUrl: data['postUrl'],
      username: data['username'],
      description: data['description'],
      datePublished: data['datePublished'],
      profImage: data['profImage'],
      likes: data['likes'],
    );
  }
}
