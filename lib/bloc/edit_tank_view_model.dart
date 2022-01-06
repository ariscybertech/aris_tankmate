import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tank_mates/bloc/species_comparator.dart';
import 'package:tank_mates/bloc/tank_validator.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/data/model/tank.dart';
import 'package:tank_mates/data/model/tank_state.dart';
import 'package:tank_mates/data/persistence/dao/tank_dao.dart';
import 'package:tank_mates/util/constants.dart';

class EditTankViewModel extends ChangeNotifier {
  TankState _tankState = TankState();
  TankDao _tankDao = TankDao();
  TankValidator _tankValidator = TankValidator();
  SpeciesComparator _speciesComparator = SpeciesComparator();

  List<Species> availableSpecies = [];
  int speciesFilter = 0; // TODO: Move filtering into separate VM

  void updateTankState() {
    _updateParameters();
    _updateTankStatus();
    _updateRecommendations();
    notifyListeners();
  }

  void _updateParameters() {
    _tankState.aggressiveness =
        _speciesComparator.determineAggressiveness(_tankState.speciesAdded);
    _tankState.careLevel =
        _speciesComparator.determineCareLevel(_tankState.speciesAdded);

    _tankState.percentFilled = _speciesComparator.determineStockingPercent(
        _tankState.speciesAdded, _tankState.gallons);

    _tankState.tempMin =
        _speciesComparator.determineMinTemp(_tankState.speciesAdded);
    _tankState.tempMax =
        _speciesComparator.determineMaxTemp(_tankState.speciesAdded);

    _tankState.phMin =
        _speciesComparator.determineMinPh(_tankState.speciesAdded);
    _tankState.phMax =
        _speciesComparator.determineMaxPh(_tankState.speciesAdded);

    _tankState.hardnessMin =
        _speciesComparator.determineMinHardness(_tankState.speciesAdded);
    _tankState.hardnessMax =
        _speciesComparator.determineMaxHardness(_tankState.speciesAdded);
  }

  void _updateTankStatus() {
    if (_tankValidator.isTankOverstocked(_tankState)) {
      _tankState.status = TankStatus.Overstocked;
    } else if (!_tankValidator.isValidTank(_tankState)) {
      _tankState.status = TankStatus.Warning;
    } else {
      _tankState.status = TankStatus.Good;
    }
  }

  void _updateRecommendations() {
    _tankState.recommendationList.clear();

    if (_tankState.status == TankStatus.Warning) {
      _tankState.recommendationList.add(kRecParamWarning);
    }

    if (_tankState.status == TankStatus.Overstocked) {
      _tankState.recommendationList.add(kRecUpgradeTank);
    }

    List<Species> oversizedSpecies =
        _speciesComparator.determineFishOverMinTankSize(
            _tankState.speciesAdded, _tankState.gallons);

    if (oversizedSpecies.length > 0) {
      for (Species fish in oversizedSpecies) {
        _tankState.recommendationList.add(
            '${fish.name} needs at least a ${fish.minTankSize} gallon tank');
      }
    }

    _tankState.recommendationList.add(_speciesComparator
        .determineRecommendationFood(_tankState.speciesAdded));

    if (_tankState.speciesAdded.isEmpty) {
      _tankState.recommendationList = ['Add some fish to your tank!'];
    }
  }

  UnmodifiableListView<Species> get addedFish {
    return UnmodifiableListView(_tankState.speciesAdded);
  }

  TankState get tankState {
    return _tankState;
  }

  /* Return a list of unique species with quantity of each, ex: 'x3 Angelfish' */
  UnmodifiableListView<String> get addedSpeciesConsolidated {
    List<Species> distinctFish =
        LinkedHashSet<Species>.from(_tankState.speciesAdded).toList();
    List<int> numFish = List.filled(distinctFish.length, 0);
    List<String> consolidatedList = [];

    for (int i = 0; i < distinctFish.length; i++) {
      for (Species fish in _tankState.speciesAdded) {
        if (distinctFish[i] == fish) {
          numFish[i]++;
        }
      }

      consolidatedList.add('x${numFish[i]} ${distinctFish[i].name}');
    }

    return UnmodifiableListView(consolidatedList);
  }

  /* Return a species object from a consolidated string, ex: 'x3 Angelfish' -> Species Object of Angelfish */
  Species speciesFromConsolidatedString(String speciesString) {
    var parts = speciesString.split(' ');
    var speciesName = parts.sublist(1).join(' ').trim();

    return availableSpecies
        .where((species) => species.name == speciesName)
        .first;
  }

  /* Return the current amount of a species added to the tank, ex: 'x3 Angelfish' -> 3 */
  int quantityOfSpecies(Species species) {
    return _tankState.speciesAdded.where((spec) => spec == species).length;
  }

  void addSpecies(Species species) {
    _tankState.speciesAdded.add(species);
    updateTankState();
  }

  /* Remove single instance of a species, ex: 'x3 Angelfish' -> 'x2 Angelfish' */
  void removeSpeciesOnce(Species species) {
    int lastIndex = _tankState.speciesAdded.lastIndexOf(species);

    if (lastIndex > -1) _tankState.speciesAdded.removeAt(lastIndex);

    updateTankState();
  }

  /* Remove all instances of a species, ex: 'x3 Angelfish' -> 'x0 Angelfish' */
  void removeSpecies(Species species) {
    _tankState.speciesAdded.removeWhere((item) => item.key == species.key);
    updateTankState();
  }

  void setTankName(String name) {
    _tankState.tankName = name;
  }

  /* Set the available species the user can select from */
  void setAvailableSpecies(List<Species> speciesList) {
    availableSpecies = speciesList;
  }

  void setTankGallons(int newGallons) {
    _tankState.gallons = newGallons;
  }

  void incrementTankGallons() {
    _tankState.gallons++;
    updateTankState();
  }

  void decrementTankGallons() {
    _tankState.gallons--;
    updateTankState();
  }

  /* Resets the tank to default values, saving after this will save a new tank */
  void resetTank() async {
    _tankState = TankState();
    speciesFilter = 0;

    updateTankState();
  }

  void loadSavedTank(Tank tankDataToLoad) {
    _tankState = TankState();
    _tankState.speciesAdded = [];

    _tankState.id = tankDataToLoad.id;
    _tankState.tankName = tankDataToLoad.name;
    _tankState.gallons = tankDataToLoad.gallons;

    List<String> addedSpeciesKeys =
        tankDataToLoad.species.map((species) => species.key).toList();

    for (String key in addedSpeciesKeys) {
      //find fish object by key (scientific name)
      for (Species fish in availableSpecies) {
        if (fish.key == key) {
          _tankState.speciesAdded.add(fish);
        }
      }
    }

    updateTankState();
  }

  void saveTank() async {
    final currentTank = Tank(_tankState.id, _tankState.tankName,
        _tankState.gallons, _tankState.speciesAdded);

    final savedTank = await _tankDao.updateOrInsert(currentTank);
    _tankState.id = savedTank.id;
  }

  void deleteTank(Tank tank) async {
    _tankDao.deleteTank(tank.id);
    notifyListeners();
  }

  Future<List<Tank>> savedTanks() async {
    return await _tankDao.getAllTanks(availableSpecies);
  }

  List<String> speciesGroups() {
    var speciesGroups = availableSpecies
        .map((species) => species.speciesGroup)
        .toSet()
        .toList();
    speciesGroups.sort();
    return speciesGroups;
  }

  void setSpeciesFilter(int value) {
    speciesFilter = value;
    notifyListeners();
  }
}
