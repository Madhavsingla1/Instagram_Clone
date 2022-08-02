import 'package:insta_clone/import.dart';
import 'package:insta_clone/model/user_model.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigatepage(value) {
    _pageController.jumpToPage(value);
  }

  void onpagechanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onpagechanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: mobileBackgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: primaryColor),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Id",
          )
        ],
        onTap: (value) {
          navigatepage(value);
        },
        showUnselectedLabels: false,
        currentIndex: _page,
        showSelectedLabels: true,
      ),
    );
  }
}





  // Not acc to the statemanagment principle
  // String username = "";

  // void initState() {
  //   super.initState();
  //   getusername();
  // }

  // void getusername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }