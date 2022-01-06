import 'package:flutter/material.dart';
import 'package:tank_mates/util/constants.dart';

class SmallCardButton extends StatelessWidget {
  SmallCardButton(
      {@required this.icon, this.leftMargin, this.rightMargin, this.onTap});

  final Function onTap;
  final IconData icon;
  final double leftMargin;
  final double rightMargin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: rightMargin,
          left: leftMargin,
          bottom: 5.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
          ),
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Icon(
          icon,
          size: 24.0,
          color: kBackGroundColor,
        ),
      ),
    );
  }
}
