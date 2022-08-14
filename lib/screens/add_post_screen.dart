import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/import.dart';
import 'package:insta_clone/resources/firebase_methods.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/model/user_model.dart' as model;

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethod().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage);

      if (res == "Success") {
        setState(() {
          isLoading = false;
        });
        clearImage();
        ShowSnackBar("Posted!", context);
      } else {
        setState(() {
          isLoading = false;
        });

        ShowSnackBar(res, context);
      }
    } catch (e) {
      ShowSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create a Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Take a Photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: Text("Choose From Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () {
                  _selectImage(context);
                },
                icon: Icon(Icons.upload)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text("Post to"),
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.uid, user.username, user.photoUrl),
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            body: Column(
              children: [
                isLoading
                    ? LinearProgressIndicator()
                    : Padding(
                        padding: EdgeInsets.all(0),
                      ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: MemoryImage(_file!), fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: _descriptionController,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Write a Caption ..",
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
