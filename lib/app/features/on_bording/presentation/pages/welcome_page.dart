import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class welcome_page extends StatelessWidget {
  final String image_path;
  final String title;
  final String description;
  welcome_page({
    super.key,
    required this.image_path,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
            child: SvgPicture.asset(
          image_path,
          width: 20,
          height: 250,
        )),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
