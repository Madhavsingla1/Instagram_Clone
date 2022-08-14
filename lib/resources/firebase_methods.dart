import 'package:insta_clone/import.dart';
import 'package:insta_clone/model/comment_model.dart';
import 'package:insta_clone/model/post_model.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String desription,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
        profImage: profImage,
        description: desription,
        uid: uid,
        postId: postId,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "Success";
    } catch (er) {
      res = er.toString();
    }
    return res;
  }

  Future<void> likePost(String postid, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> comment(String postid, String uid, String comment,
      String profilePic, String username) async {
    String res = "Some thing is wrong";
    try {
      if (comment.isNotEmpty) {
        String commentid = const Uuid().v1();
        Comment comm = Comment(
          username: username,
          comments: comment,
          postid: postid,
          uid: uid,
          profilePic: profilePic,
          commentid: commentid,
          datePublished: DateTime.now(),
        );
        await _firestore
            .collection('posts')
            .doc(postid)
            .collection("comments")
            .doc(commentid)
            .set(
              comm.toMap(),
            );
      } else {
        print("Text is Empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
