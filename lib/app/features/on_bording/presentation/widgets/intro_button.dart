import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:news_app/app/config/thems/light_them.dart';
import 'package:news_app/app/features/display_news/presentation/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroButton extends StatelessWidget {
  const IntroButton({
    super.key,
    required this.pageController,
    required this.isLastPage,
    required this.language,
  });

  final PageController pageController;
  final bool isLastPage;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DottedBorder(
            strokeWidth: 2,
            color: Colors.blue,
            padding: const EdgeInsets.all(5),
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            dashPattern: const [20, 25, 20, 0],
            child: InkWell(
              onTap: () async {
                pageController.nextPage(
                    duration: const Duration(seconds: 1), curve: Curves.easeIn);
                if (!isLastPage) {
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  localStorage.setBool("showOnBordingPages", false);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(Language: language),
                      ));
                }
              },
              child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: !isLastPage
                          ? Colors.blue[100]
                          : LightTheme.primeryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: isLastPage ? Colors.white : LightTheme.primeryColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
