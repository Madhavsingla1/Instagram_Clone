import 'package:insta_clone/import.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1543660029-e2fd1a6d7e05?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80"),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 8.0, left: 16),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Comment as username",
                      border: InputBorder.none),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
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
