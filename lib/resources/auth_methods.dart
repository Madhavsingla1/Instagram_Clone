import 'package:insta_clone/import.dart';
import 'package:insta_clone/model/user_model.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User id = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(id.uid).get();
    // debugPrint(snap.data().toString());
    return model.User.fromsnap(snap);
  }

  // sing up user
  Future<String> singUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // ading photo to database
        String picurl = await StorageMethods()
            .uploadImageToStorage('ProfilePic', file, false);
        // print(cred.user!.uid);

        model.User user = model.User(
            bio: bio,
            username: username,
            uid: cred.user!.uid,
            email: email,
            follower: [],
            following: [],
            photoUrl: picurl);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        // Another methods
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        // });

        res = "Success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = "The email is badly formatted.";
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logging in User

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (res == "Some error occured") res = "Success";
      } else {
        res = "Please Enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      res = err.message ?? "Error";
      // print(res);
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
