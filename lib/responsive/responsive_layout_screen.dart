import 'package:insta_clone/import.dart';

class ResposiveLayout extends StatefulWidget {
  final webScreenLayout;
  final mobileScreenLayout;
  const ResposiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResposiveLayout> createState() => _ResposiveLayoutState();
}

class _ResposiveLayoutState extends State<ResposiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //web screen
          return widget.webScreenLayout;
        } else {
          //mobile screen
          return widget.mobileScreenLayout;
        }
      },
    );
  }
}
