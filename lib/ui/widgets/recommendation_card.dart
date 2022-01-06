import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/util/constants.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> recommendationList =
        Provider.of<EditTankViewModel>(context).tankState.recommendationList;

    return Container(
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: kCardColor,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Recommendations",
            style: kTextStyleSmall,
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendationList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                '- ${recommendationList[index]}',
                style: kTextStyleSmall,
              );
            },
          ),
        ],
      ),
    );
  }
}
