import 'package:flutter/material.dart';

class StudentItem extends StatelessWidget {
  final int id;
  final String name;
  final VoidCallback onPress;

  StudentItem(
      {Key? key, required this.id, required this.name, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 79, 79, 79), width: 1))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 25,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
      onTap: () {
        onPress();
      },
    );
  }
}
