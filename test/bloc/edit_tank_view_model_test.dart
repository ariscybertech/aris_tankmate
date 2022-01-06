import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/bloc/edit_tank_view_model.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/data/model/tank.dart';
import 'package:tank_mates/data/persistence/hive/hive_constants.dart';

final Species exampleSpecies = Species(
    "Tetraodon abei",
    "Abei Puffer",
    "Tetraodon abei",
    "puffer",
    Aggressiveness.aggressive,
    6.0,
    7.8,
    73,
    81,
    3,
    15,
    CareLevel.moderate,
    4,
    Diet.carnivore,
    20);

final Species exampleSpecies2 = Species(
    "Aequidens diadema",
    "Acara",
    "Aequidens diadema",
    "american cichlids",
    Aggressiveness.semi_aggressive,
    6.6,
    7.5,
    72,
    83,
    4,
    20,
    CareLevel.moderate,
    4.7,
    Diet.omnivore,
    29);

void main() {
  addedSpeciesConsolidated();
  speciesFromConsolidatedString();
  quantityOfSpecies();
  addSpecies();
  removeSpecies();
  removeSpeciesOnce();
  setTankName();
  setAvailableSpecies();
  setTankGallons();
  incrementTankGallons();
  decrementTankGallons();
  resetTank();
  loadSavedTank();
}

void addedSpeciesConsolidated() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('addedSpeciesConsolidated generates expected strings', () {
    viewModel.addSpecies(exampleSpecies);
    viewModel.addSpecies(exampleSpecies2);
    viewModel.addSpecies(exampleSpecies2);

    expect(viewModel.addedFish.length, 3);
    expect(viewModel.addedSpeciesConsolidated.length, 2);
    expect(viewModel.addedSpeciesConsolidated.length, 2);
    expect(viewModel.addedSpeciesConsolidated[0], 'x1 Abei Puffer');
    expect(viewModel.addedSpeciesConsolidated[1], 'x2 Acara');
  });
}

void speciesFromConsolidatedString() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('speciesFromConsolidatedString returns expected species model', () {
    viewModel.setAvailableSpecies([exampleSpecies, exampleSpecies2]);

    expect(viewModel.speciesFromConsolidatedString('x1 Abei Puffer'),
        exampleSpecies);
    expect(
        viewModel.speciesFromConsolidatedString('x3 Acara'), exampleSpecies2);
  });
}

void quantityOfSpecies() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('quantityOfSpecies returns expected number per species', () {
    viewModel.addSpecies(exampleSpecies);
    viewModel.addSpecies(exampleSpecies2);
    viewModel.addSpecies(exampleSpecies2);
    viewModel.addSpecies(exampleSpecies2);

    expect(viewModel.addedFish.length, 4);
    expect(viewModel.quantityOfSpecies(exampleSpecies), 1);
    expect(viewModel.quantityOfSpecies(exampleSpecies2), 3);
  });
}

void addSpecies() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('Adding fish updates state', () {
    expect(viewModel.addedFish.length, 0);
    expect(viewModel.tankState.aggressiveness, Aggressiveness.peaceful);

    //add fish
    viewModel.addSpecies(exampleSpecies);

    expect(viewModel.addedFish.length, 1);
    expect(viewModel.tankState.aggressiveness, Aggressiveness.aggressive);
    expect(viewModel.tankState.speciesAdded, [exampleSpecies]);
  });
}

void removeSpecies() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('Removing fish updates state', () {
    expect(viewModel.addedFish.length, 0);

    // Add species multiple times
    viewModel.addSpecies(exampleSpecies);
    viewModel.addSpecies(exampleSpecies);
    expect(viewModel.addedFish.length, 2);

    // Remove species, ensure all are removed
    viewModel.removeSpecies(exampleSpecies);
    expect(viewModel.addedFish.length, 0);
  });
}

void removeSpeciesOnce() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('Removing fish updates state', () {
    expect(viewModel.addedFish.length, 0);

    // Add species multiple times
    viewModel.addSpecies(exampleSpecies);
    viewModel.addSpecies(exampleSpecies);
    expect(viewModel.addedFish.length, 2);

    // Remove species once, ensure only one instance is removed
    viewModel.removeSpeciesOnce(exampleSpecies);
    expect(viewModel.addedFish.length, 1);
  });
}

void setTankName() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('Set name updates state', () {
    viewModel.setTankName('Name 1');
    expect(viewModel.tankState.tankName, 'Name 1');

    viewModel.setTankName('Name 2');
    expect(viewModel.tankState.tankName, 'Name 2');
  });
}

void setAvailableSpecies() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('Set available species updates state', () {
    viewModel.setAvailableSpecies([exampleSpecies]);
    expect(viewModel.availableSpecies.length, 1);

    viewModel.setAvailableSpecies([]);
    expect(viewModel.availableSpecies.length, 0);
  });
}

void setTankGallons() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('Set gallons updates state', () {
    viewModel.setTankGallons(50);
    expect(viewModel.tankState.gallons, 50);

    viewModel.setTankGallons(100);
    expect(viewModel.tankState.gallons, 100);
  });
}

void incrementTankGallons() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('incrementTankGallons updates state', () {
    viewModel.setTankGallons(0);
    viewModel.incrementTankGallons();
    expect(viewModel.tankState.gallons, 1);

    viewModel.incrementTankGallons();
    expect(viewModel.tankState.gallons, 2);
  });
}

void decrementTankGallons() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('decrementTankGallons updates state', () {
    viewModel.setTankGallons(5);
    viewModel.decrementTankGallons();
    expect(viewModel.tankState.gallons, 4);

    viewModel.decrementTankGallons();
    expect(viewModel.tankState.gallons, 3);
  });
}

void resetTank() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('resetTank reflects correct ID', () {
    expect(viewModel.tankState.id, kDefaultTankId);

    viewModel.loadSavedTank(Tank(123, '', 0, []));
    expect(viewModel.tankState.id, 123);

    viewModel.resetTank();
    expect(viewModel.tankState.id, kDefaultTankId);
  });
}

void loadSavedTank() {
  final EditTankViewModel viewModel = EditTankViewModel();

  test('loadSavedTank reflects correct ID', () {
    expect(viewModel.tankState.id, kDefaultTankId);

    viewModel.loadSavedTank(Tank(123, '', 0, []));
    expect(viewModel.tankState.id, 123);
  });
}
