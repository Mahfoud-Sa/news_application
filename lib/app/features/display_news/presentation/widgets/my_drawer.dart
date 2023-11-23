import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/presentation/pages/setting_page.dart';
import 'package:news_app/app/features/display_news/presentation/widgets/drawer_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _closeSection(),
          //title
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'News Application',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          //buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}

class _closeSection extends StatelessWidget {
  const _closeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 150,
                width: 130,
                //color: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 35,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
