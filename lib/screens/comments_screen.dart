import 'package:insta_clone/import.dart';
import 'package:insta_clone/widgets/comment_card.dart';
import 'package:insta_clone/model/user_model.dart' as model;

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late TextEditingController _commentcontroller;

  @override
  void initState() {
    super.initState();
    _commentcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _commentcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts/${widget.snap['postId']}/comments')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 8.0, left: 16),
                child: TextField(
                  controller: _commentcontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "Comment as ${user.username}",
                      border: InputBorder.none),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await FireStoreMethod().comment(widget.snap['postId'], user.uid,
                    _commentcontroller.text, user.photoUrl, user.username);
                setState(() {
                  _commentcontroller.text = "";
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Text(
                  "post",
                  style: TextStyle(
                    color: blueColor,
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
