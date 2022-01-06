import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/util/constants.dart';

class FilterListScreen extends StatefulWidget {
  FilterListScreen();

  @override
  _FilterListScreenState createState() => _FilterListScreenState();
}

class _FilterListScreenState extends State<FilterListScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditTankViewModel>(context, listen: false);
    final speciesGroups = ['All'] + viewModel.speciesGroups();
    final filterIndex = viewModel.speciesFilter;

    return Container(
      color: kModalBackgroundColor,
      child: Container(
        padding: kModalPadding,
        decoration: kModalBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Filter by Species Group',
              textAlign: TextAlign.center,
              style: kTextStyleHeader,
            ),
            Container(
              height: 400.0,
              child: ListView.builder(
                itemCount: speciesGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Divider(),
                      RadioListTile(
                        value: index,
                        groupValue: filterIndex,
                        title: Text(
                            toBeginningOfSentenceCase(speciesGroups[index])),
                        onChanged: (val) {
                          setState(() {
                            viewModel.setSpeciesFilter(val);
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            TextButton(
              child: Text(
                'Filter',
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
