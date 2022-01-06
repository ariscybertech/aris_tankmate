import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/bloc/settings_view_model.dart';
import 'package:tank_mates/data/model/settings.dart';
import 'package:tank_mates/util/constants.dart';

class SettingsScreen extends StatefulWidget {
  static final String id = kIdSettingsScreen;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final leftPadding = EdgeInsets.only(right: 16.0);

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel settingsViewModel =
        Provider.of<SettingsViewModel>(context);
    final EditTankViewModel tankViewModel =
        Provider.of<EditTankViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        title: Text(
          appName,
          style: kTextStyleHeader,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'App Settings',
            style: kTextStyleLarge,
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: leftPadding,
                child: Text(
                  'Temperature Unit',
                  style: kTextStyleSmall,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: leftPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue:
                            settingsViewModel.settings.temperatureUnit.index,
                        onChanged: (value) {
                          setState(() {
                            settingsViewModel.updateTemperatureUnit(
                                TemperatureUnit.values[value]);
                            tankViewModel.updateTankState();
                          });
                        },
                      ),
                      Text(
                        'fahrenheit',
                        style: kTextStyleSmall,
                      ),
                      Radio(
                        value: 1,
                        groupValue:
                            settingsViewModel.settings.temperatureUnit.index,
                        onChanged: (value) {
                          setState(() {
                            settingsViewModel.updateTemperatureUnit(
                                TemperatureUnit.values[value]);
                            tankViewModel.updateTankState();
                          });
                        },
                      ),
                      Text(
                        'celsius',
                        style: kTextStyleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: leftPadding,
                child: Text(
                  'Water Volume Unit',
                  style: kTextStyleSmall,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: leftPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: settingsViewModel.settings.volumeUnit.index,
                        onChanged: (value) {
                          setState(() {
                            settingsViewModel
                                .updateVolumeUnit(VolumeUnit.values[value]);
                            tankViewModel.updateTankState();
                          });
                        },
                      ),
                      Text(
                        'gallons',
                        style: kTextStyleSmall,
                      ),
                      Radio(
                        value: 1,
                        groupValue: settingsViewModel.settings.volumeUnit.index,
                        onChanged: (value) {
                          setState(() {
                            settingsViewModel
                                .updateVolumeUnit(VolumeUnit.values[value]);
                            tankViewModel.updateTankState();
                          });
                        },
                      ),
                      Text(
                        'liters',
                        style: kTextStyleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
