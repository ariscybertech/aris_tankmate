import 'package:flutter/material.dart';

// Assets
const kFreshwaterSpeciesJson = 'assets/freshwater_data.json';

// Screen IDs
const kIdLoadingScreen = 'loading_screen';
const kIdEditTankScreen = 'edit_tank_screen';
const kIdSavedTanksScreen = 'saved_tanks_screen';
const kIdAboutScreen = 'about_screen';
const kIdSettingsScreen = 'settings_screen';

const String appName = 'Tank Mates';

//Recommendation constants
const String kRecFoodCarnivore =
    'Ensure you are providing your fish a meat based food';
const String kRecFoodHerbivore =
    'Ensure you are providing your fish a plant based food';
const String kRecFoodOmnivore =
    'Ensure you are providing your fish both plant and meat based foods';
const String kRecUpgradeTank = 'You are overstocked, upgrade your tank size';
const String kRecParamWarning =
    'Warning, there may be incompatible parameters for the selected species';
const String kUnknownParameter = '?? - ??';

const kPrimaryColor = const Color(0xFF3D6E90);
const kBackGroundColor = const Color(0xFFFDFDFD);
const kSecondaryColor = const Color(0xFF3c4146);
const kModalBackgroundColor = const Color(0xff757575);
const kCardColor = kPrimaryColor;

const kModalBoxDecoration = BoxDecoration(
  color: kBackGroundColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  ),
);

const kModalPadding = EdgeInsets.all(20.0);
const kContainerBottomMargin = EdgeInsets.only(
  bottom: 10.0,
);

const kTextStyleSmall = TextStyle(
  fontSize: 14.0,
  color: kSecondaryColor,
  fontFamily: 'Oswald',
);

const kTextStyleHeader = TextStyle(
  fontSize: 24.0,
  color: kPrimaryColor,
  fontFamily: 'Oswald',
);

const kTextStyleLarge = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
  fontFamily: 'Oswald',
);

const kRecommendationTextStyle = TextStyle(
  fontSize: 18.0,
  color: kPrimaryColor,
  fontFamily: 'Oswald',
);

const kListItemTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 18.0,
  color: kSecondaryColor,
);

const kPrimaryButtonTextStyle = TextStyle(
  color: kBackGroundColor,
  fontFamily: 'Oswald',
  fontSize: 18.0,
);

const kRichTextLinkFontSize = 22.0;
const kRichTextFontSize = 20.0;

const List<AppBarChoice> appBarChoices = const <AppBarChoice>[
  const AppBarChoice('Settings', kIdSettingsScreen),
  const AppBarChoice('About', kIdAboutScreen),
];

class AppBarChoice {
  const AppBarChoice(this.title, this.id);

  final String title;
  final String id;
}
