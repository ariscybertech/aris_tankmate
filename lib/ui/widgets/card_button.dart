import 'package:flutter/material.dart';
import 'package:tank_mates/util/constants.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15.0,
        bottom: 5.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: kCardColor,
        ),
        color: kCardColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Icon(
        Icons.add,
        size: 80.0,
        color: kBackGroundColor,
      ),
    );
  }
}
