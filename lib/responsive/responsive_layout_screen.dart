import 'package:flutter/material.dart';
import 'package:insta_clone/utils/dimesions.dart';

class ResposiveLayout extends StatelessWidget {
  final webScreenLayout;
  final mobileScreenLayout;
  const ResposiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          //web screen
          return webScreenLayout;
        } else {
          //mobile screen
          return mobileScreenLayout;
        }
      },
    );
  }
}
