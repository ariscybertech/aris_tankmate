import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/data/json/species_json_parser.dart';
import 'package:tank_mates/ui/screens/edit_tank_screen.dart';
import 'package:tank_mates/util/constants.dart';

class LoadingScreen extends StatefulWidget {
  static final String id = kIdLoadingScreen;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getFishData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SpinKitDoubleBounce(
            color: kPrimaryColor,
            size: 100.0,
          ),
          Text(
            '$appName',
            style: kTextStyleLarge,
          )
        ],
      ),
    );
  }

  void getFishData() async {
    final viewModel = Provider.of<EditTankViewModel>(context, listen: false);
    final json = await rootBundle.loadString(kFreshwaterSpeciesJson);
    final speciesList = SpeciesJsonParser().parseJsonToSpeciesList(json);

    viewModel.setAvailableSpecies(speciesList);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditTankScreen();
    }));
  }
}
