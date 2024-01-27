import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/presentation/pages/homePage.dart';
import 'package:news_app/app/features/on_bording/presentation/widgets/intro_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_page.dart';

class OnBording extends StatefulWidget {
  final String Language;
  const OnBording({super.key, required this.Language});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  final pageController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: !isLastPage
                  ? TextButton(
                      onPressed: () async {
                        SharedPreferences localStorage =
                            await SharedPreferences.getInstance();
                        localStorage.setBool("showOnBordingPages", false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(Language: widget.Language),
                            ));
                      },
                      child: const Text('Skip'))
                  : null,
            )
          ],
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height - 50,
          child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  if (index == 2) {
                    isLastPage = true;
                  } else {
                    isLastPage = false;
                  }
                });
              },
              children: [
                welcome_page(
                  image_path: 'assets/svgs/img (1).svg',
                  title: 'News around the hole world',
                  description:
                      'get different news from different sources ,around the multable sources',
                ),
                welcome_page(
                  image_path: 'assets/svgs/img (2).svg',
                  title: 'Search the news around the word',
                  description:
                      'to using Conte adable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites st',
                ),
                welcome_page(
                  image_path: 'assets/svgs/img (3).svg',
                  title: 'Save different and multabe articles',
                  description:
                      'to using Content here, content here, their infancy. Various versions have evolved over the years,.',
                ),
              ]),
        ),
        bottomNavigationBar: IntroButton(
          pageController: pageController,
          isLastPage: isLastPage,
          language: widget.Language,
        ));
  }
}
