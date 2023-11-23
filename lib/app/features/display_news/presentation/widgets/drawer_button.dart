import 'package:flutter/material.dart';
import 'package:news_app/app/features/display_news/presentation/pages/setting_page.dart';

class DrawerBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  Function myAction;

  DrawerBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.myAction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: myAction(),
      child: Container(
        height: 60,
        width: 250,
        child: Card(
          color: const Color.fromARGB(256, 246, 246, 246),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
