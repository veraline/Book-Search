import 'package:bookstore/view/book_Search_Screen.dart';
import 'package:bookstore/view/home.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({super.key});

  final List<Introduction> list = [
    Introduction(
        imageUrl: 'assets/first_screen.png',
        title: 'Select a book',
        subTitle: 'Select any book of your choice'),
    Introduction(
        imageUrl: 'assets/first_screen.png',
        title: 'Purchase Online',
        subTitle: 'Select any book of your choice'),
    Introduction(
        imageUrl: 'assets/first_screen.png',
        title: 'Get Delivered',
        subTitle: 'Select any book of your choice'),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BookSearchScreen()));
      },
    );
  }
}
