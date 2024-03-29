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

  // Delete Post
  // Have to change as the delete post is deleting all the post from one user only
  // change it to auth method in which we can delete the post posted by the same user.
  Future<void> deletePost(
    String postId,
  ) async {
    try {
      _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // Follow User

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
        await _firestore.collection('users').doc(followId).update({
          'follower': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
        await _firestore.collection('users').doc(followId).update({
          'follower': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
