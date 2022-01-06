import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/bloc/settings_view_model.dart';
import 'package:tank_mates/data/model/tank_state.dart';
import 'package:tank_mates/ui/screens/about_screen.dart';
import 'package:tank_mates/ui/screens/add_fish_screen.dart';
import 'package:tank_mates/ui/screens/edit_species_screen.dart';
import 'package:tank_mates/ui/screens/settings_screen.dart';
import 'package:tank_mates/ui/screens/tank_settings_screen.dart';
import 'package:tank_mates/ui/widgets/card_button.dart';
import 'package:tank_mates/ui/widgets/menu_bar.dart';
import 'package:tank_mates/ui/widgets/parameter_tile.dart';
import 'package:tank_mates/ui/widgets/recommendation_card.dart';
import 'package:tank_mates/ui/widgets/small_card_button.dart';
import 'package:tank_mates/util/constants.dart';

class EditTankScreen extends StatefulWidget {
  static final String id = kIdEditTankScreen;

  @override
  _EditTankScreenState createState() => _EditTankScreenState();
}

class _EditTankScreenState extends State<EditTankScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _loadSettings();
  }

  void _selectTopIndex(AppBarChoice choice) {
    if (choice.id == kIdAboutScreen) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AboutScreen()));
    } else if (choice.id == kIdSettingsScreen) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    }
  }

  void _loadSettings() async {
    final viewModel = Provider.of<SettingsViewModel>(context, listen: false);
    await viewModel.loadSettings();

    // Ensure initial tank is updated for loaded settings
    Provider.of<EditTankViewModel>(context, listen: false).updateTankState();
  }

  @override
  Widget build(BuildContext context) {
    final TankState state = Provider.of<EditTankViewModel>(context).tankState;
    final EditTankViewModel viewModel =
        Provider.of<EditTankViewModel>(context, listen: false);
    final SettingsViewModel settingsViewModel =
        Provider.of<SettingsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: kTextStyleHeader,
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<AppBarChoice>(
            icon: Icon(
              Icons.opacity,
              color: kPrimaryColor,
            ),
            onSelected: _selectTopIndex,
            itemBuilder: (BuildContext context) {
              return appBarChoices.map((AppBarChoice choice) {
                return PopupMenuItem<AppBarChoice>(
                  value: choice,
                  child: Text(
                    choice.title,
                    style: kTextStyleSmall,
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MenuBar(true),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ParameterTile(
                                  label: 'Temperature',
                                  value: isValueValid(state.tempMin.toDouble(),
                                              state.tempMax.toDouble()) &&
                                          state.hasSpecies()
                                      ? '${settingsViewModel.temperature(state.tempMin)} - '
                                          '${settingsViewModel.temperature(state.tempMax)} ${settingsViewModel.temperatureUnit()}'
                                      : '$kUnknownParameter',
                                ),
                                ParameterTile(
                                  label: 'pH',
                                  value:
                                      isValueValid(state.phMin, state.phMax) &&
                                              state.hasSpecies()
                                          ? '${state.phMin} - '
                                              '${state.phMax}'
                                          : '$kUnknownParameter',
                                ),
                                ParameterTile(
                                  label: 'Hardness',
                                  value: isValueValid(
                                              state.hardnessMin.toDouble(),
                                              state.hardnessMax.toDouble()) &&
                                          state.hasSpecies()
                                      ? '${state.hardnessMin} - '
                                          '${state.hardnessMax} dKH'
                                      : '$kUnknownParameter',
                                ),
                                ParameterTile(
                                  label: 'Care Level',
                                  value:
                                      '${toBeginningOfSentenceCase(state.careLevel.toString().split('.').last)}',
                                ),
                              ],
                            ),
                          ),
                          RecommendationCard(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: TankSettingsScreen(),
                                ),
                              ),
                            );
                          },
                          child: Container(
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
                                ParameterTile(
                                  label: 'Tank Status: '
                                      '${toBeginningOfSentenceCase(state.status.toString().split('.').last)}',
                                  value: '${state.percentFilled} %',
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${settingsViewModel.volume(state.gallons)} ${settingsViewModel.volumeUnit()} aquarium',
                                      style: kTextStyleSmall,
                                    ),
                                    Icon(
                                      Icons.tune,
                                      size: 24.0,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${state.speciesAdded.length} fish added',
                                style: kTextStyleHeader,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Consumer<EditTankViewModel>(
                              builder: (context, addedFishData, child) {
                            if (addedFishData.addedSpeciesConsolidated.length >
                                0) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: addedFishData
                                      .addedSpeciesConsolidated.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final species = addedFishData
                                        .addedSpeciesConsolidated[index];
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      secondaryActions: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 15.0,
                                          ),
                                          child: IconSlideAction(
                                            foregroundColor: kPrimaryColor,
                                            color: kBackGroundColor,
                                            icon: Icons.delete,
                                            onTap: () => viewModel
                                                .removeSpecies(viewModel
                                                    .speciesFromConsolidatedString(
                                                        species)),
                                          ),
                                        )
                                      ],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Divider(),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) =>
                                                    SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: EditSpeciesScreen(
                                                        viewModel
                                                            .speciesFromConsolidatedString(
                                                                species)),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      '$species',
                                                      style: kTextStyleSmall,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 24.0,
                                                    color: kSecondaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Divider(),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: AddFishScreen(
                                    availableSpecies:
                                        viewModel.availableSpecies,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: CardButton(),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: SmallCardButton(
                                icon: Icons.save,
                                leftMargin: 15.0,
                                rightMargin: 5.0,
                                onTap: () async {
                                  viewModel.saveTank();
                                },
                              ),
                            ),
                            Expanded(
                              child: SmallCardButton(
                                icon: Icons.refresh,
                                leftMargin: 5.0,
                                rightMargin: 15.0,
                                onTap: () {
                                  viewModel.resetTank();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isValueValid(double minValue, double maxValue) {
  if (minValue <= maxValue) {
    return true;
  }
  return false;
}
