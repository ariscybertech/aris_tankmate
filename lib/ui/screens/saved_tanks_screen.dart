import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/data/model/tank.dart';
import 'package:tank_mates/ui/screens/about_screen.dart';
import 'package:tank_mates/ui/screens/settings_screen.dart';
import 'package:tank_mates/ui/widgets/menu_bar.dart';
import 'package:tank_mates/util/constants.dart';

class SavedTanksScreen extends StatefulWidget {
  static final String id = kIdSavedTanksScreen;

  @override
  _SavedTanksScreenState createState() => _SavedTanksScreenState();
}

class _SavedTanksScreenState extends State<SavedTanksScreen> {
  //final List<String> savedTankList = [];

  void _selectTopIndex(AppBarChoice choice) {
    if (choice.id == kIdAboutScreen) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AboutScreen()));
    } else if (choice.id == kIdSettingsScreen) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditTankViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
        title: Text(
          appName,
          style: kTextStyleHeader,
        ),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          MenuBar(false),
          Expanded(
            child: FutureBuilder<List<Tank>>(
              future: viewModel.savedTanks(),
              initialData: [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text(
                        'Error loading saved tanks...',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return _buildTankList(context, snapshot.data);
                  }
                }
                // Displaying LoadingSpinner to indicate waiting state
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

ListView _buildTankList(BuildContext context, List<Tank> tanks) {
  final viewModel = Provider.of<EditTankViewModel>(context);

  return ListView.builder(
    itemCount: tanks.length,
    padding: const EdgeInsets.all(15.0),
    itemBuilder: (_, index) {
      final itemTask = tanks[index];
      return _buildListItem(itemTask, viewModel, context);
    },
  );
}

Widget _buildListItem(
    Tank itemTank, EditTankViewModel viewModel, BuildContext context) {
  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    secondaryActions: <Widget>[
      Container(
        margin: kContainerBottomMargin,
        child: IconSlideAction(
          foregroundColor: kPrimaryColor,
          caption: 'Edit',
          color: kBackGroundColor,
          icon: Icons.edit,
          onTap: () {
            Navigator.pop(context, itemTank);
            viewModel.loadSavedTank(itemTank);
          },
        ),
      ),
      Container(
        margin: kContainerBottomMargin,
        child: IconSlideAction(
          foregroundColor: kPrimaryColor,
          caption: 'Delete',
          color: kBackGroundColor,
          icon: Icons.delete,
          onTap: () => viewModel.deleteTank(itemTank),
        ),
      )
    ],
    child: InkWell(
      onTap: () {
        Navigator.pop(context, itemTank);
        viewModel.loadSavedTank(itemTank);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        margin: kContainerBottomMargin,
        decoration: BoxDecoration(
          border: Border.all(
            color: kCardColor,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemTank.nameTrimmedToLength(20),
                  style: kTextStyleLarge,
                ),
                Text(
                  itemTank.speciesNamesJoinedString(),
                  style: kTextStyleSmall,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(
                Icons.swipe,
                size: 22.0,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
