import 'package:flutter/material.dart';
import 'package:schoolapp/src/students_view/student_view.dart';

class CustomButton extends StatelessWidget {
  final Icon icon;
  final String title;
  final StatefulWidget target;
  const CustomButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.target});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color.fromARGB(255, 235, 235, 235),
            ),
            /*child: FittedBox(*/
            child: Row(
              children: [
                Flexible(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: icon,
                    ),
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Color.fromARGB(255, 125, 125, 125),
                            fontSize: 48.0),
                      ),
                    ),
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
        onTap: () => {_navigate(context)},
      ),
    );
    //);
  }

  _navigate(dynamic context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => target,
      ),
    );
  }
}
