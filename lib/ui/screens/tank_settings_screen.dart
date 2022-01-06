import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/ui/widgets/parameter_tile.dart';
import 'package:tank_mates/ui/widgets/round_icon_button.dart';
import 'package:tank_mates/util/constants.dart';
import 'package:tank_mates/util/unit_conversions.dart';

class TankSettingsScreen extends StatefulWidget {
  @override
  _TankSettingsScreenState createState() => _TankSettingsScreenState();
}

class _TankSettingsScreenState extends State<TankSettingsScreen> {
  final horizontalPadding = EdgeInsets.symmetric(horizontal: 8.0);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<EditTankViewModel>(context).tankState;
    final viewModel = Provider.of<EditTankViewModel>(context, listen: false);

    final textController = TextEditingController(text: '${state.tankName}');
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));

    return Container(
      color: kModalBackgroundColor,
      child: Container(
        padding: kModalPadding,
        decoration: kModalBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Tank Settings',
              textAlign: TextAlign.center,
              style: kTextStyleHeader,
            ),
            Divider(),
            Padding(
              padding: horizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tank Name',
                    style: kTextStyleSmall,
                  ),
                  TextField(
                    controller: textController,
                    style: kTextStyleLarge,
                    autofocus: false,
                    textAlign: TextAlign.start,
                    onChanged: (newText) {
                      viewModel.setTankName(newText);
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: horizontalPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ParameterTile(
                    label:
                        'Tank Size (${state.gallons} gallons | ${UnitConversions.gallonsToLiters(state.gallons)} liters)',
                    value: '${state.gallons} g',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundIconButton(
                        icon: Icons.remove,
                        onPressed: () {
                          viewModel.decrementTankGallons();
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      RoundIconButton(
                        icon: Icons.add,
                        onPressed: () {
                          viewModel.incrementTankGallons();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              child: Text(
                'Return To Edit Tank',
                style: kPrimaryButtonTextStyle,
              ),
              style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
