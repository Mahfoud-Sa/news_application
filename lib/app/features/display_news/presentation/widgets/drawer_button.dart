import 'package:flutter/material.dart';

class DrawerBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  Widget Page;

  DrawerBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.Page,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Page,
            ));
      },
      child: SizedBox(
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
