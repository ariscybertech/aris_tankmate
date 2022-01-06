import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/ui/screens/filter_list_screen.dart';
import 'package:tank_mates/util/constants.dart';

class AddFishScreen extends StatelessWidget {
  AddFishScreen({@required this.availableSpecies});

  final List<Species> availableSpecies;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditTankViewModel>(context, listen: false);
    final speciesGroups = ['All'] + viewModel.speciesGroups();
    final filterIndex = Provider.of<EditTankViewModel>(context).speciesFilter;

    List<Species> activeAvailableSpecies = availableSpecies.where((species) {
      if (filterIndex == 0)
        return true;
      else
        return species.speciesGroup == speciesGroups[filterIndex];
    }).toList();

    return Container(
      color: kModalBackgroundColor,
      child: Container(
        padding: kModalPadding,
        decoration: kModalBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Fish',
                  textAlign: TextAlign.left,
                  style: kTextStyleHeader,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: FilterListScreen(),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Filter',
                        textAlign: TextAlign.right,
                        style: kTextStyleSmall,
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.filter_list,
                        size: 32.0,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 400.0,
              child: ListView.builder(
                itemCount: activeAvailableSpecies.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      viewModel.addSpecies(activeAvailableSpecies[index]);
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Divider(),
                        Text(
                          '${activeAvailableSpecies[index].name}',
                          textAlign: TextAlign.center,
                          style: kListItemTextStyle,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextButton(
              child: Text(
                'Cancel',
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
