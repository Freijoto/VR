import 'package:flutter/material.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';
import 'package:schoolapp/src/common/utilities/school_numeric_atributes.dart';
import 'package:schoolapp/src/common/utilities/school_strings.dart';

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
          padding: SchoolPadding.medium,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(SchoolRadius.large),
              color: SchoolColors.lightButtonColor,
            ),
            /*child: FittedBox(*/
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FittedBox(
                    child: Padding(
                      padding: SchoolPadding.medium,
                      child: icon,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: FittedBox(
                    child: Padding(
                      padding: SchoolPadding.medium,
                      child: Text(
                        title,
                        style: SchoolStringsStyles.largeButtonTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => {_navigate(context)},
      ),
    );
  }

  _navigate(dynamic context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => target,
      ),
    );
  }
}
