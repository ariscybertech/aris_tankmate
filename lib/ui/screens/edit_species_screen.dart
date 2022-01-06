import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/ui/widgets/parameter_tile.dart';
import 'package:tank_mates/ui/widgets/round_icon_button.dart';
import 'package:tank_mates/util/constants.dart';

class EditSpeciesScreen extends StatefulWidget {
  final Species species;
  const EditSpeciesScreen(this.species);

  @override
  _EditSpeciesScreenState createState() => _EditSpeciesScreenState();
}

class _EditSpeciesScreenState extends State<EditSpeciesScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditTankViewModel>(context, listen: false);
    final Species species = widget.species;
    int quantity = viewModel.quantityOfSpecies(species);

    return Container(
      color: kModalBackgroundColor,
      child: Container(
        padding: kModalPadding,
        decoration: kModalBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Update ${species.name}',
              textAlign: TextAlign.center,
              style: kTextStyleHeader,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ParameterTile(
                    label: 'Quantity',
                    value: '$quantity',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundIconButton(
                        icon: Icons.remove,
                        onPressed: () {
                          setState(() {
                            quantity--;
                            if (quantity < 0) quantity = 0;
                            viewModel.removeSpeciesOnce(species);
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      RoundIconButton(
                        icon: Icons.add,
                        onPressed: () {
                          setState(() {
                            quantity++;
                            viewModel.addSpecies(species);
                          });
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
                style: TextStyle(
                  color: kBackGroundColor,
                  fontFamily: 'Oswald',
                  fontSize: 18.0,
                ),
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
