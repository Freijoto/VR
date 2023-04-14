import 'package:flutter/material.dart';
import 'package:schoolapp/src/common/utilities/school_colors.dart';
import 'package:schoolapp/src/common/utilities/school_numeric_atributes.dart';
import 'package:schoolapp/src/common/utilities/school_strings.dart';

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
        decoration: const BoxDecoration(
            color: SchoolColors.lightButtonColor,
            border: Border(
                bottom: BorderSide(
                    color: SchoolColors.listSeparatorColor, width: 1))),
        child: Padding(
          padding: SchoolPadding.medium,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: SchoolStringsStyles.mediumButtonTitle,
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
