import 'package:insta_clone/import.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // adding image to firebase storage

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool ispost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (ispost) {
      final id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadtask = ref.putData(file);

    TaskSnapshot snap = await uploadtask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
