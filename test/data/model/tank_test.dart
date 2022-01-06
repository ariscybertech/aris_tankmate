import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/data/model/tank.dart';

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
  speciesNames();
  speciesNamesJoinedString();
  nameTrimmedToLength();
}

void speciesNames() {
  test('speciesNames() returns the expected list of names', () {
    final speciesList = [exampleSpecies, exampleSpecies2, exampleSpecies2];
    final tank = Tank(0, 'Tank Name', 20, speciesList);
    final speciesNames = tank.speciesNames();

    expect(speciesNames.length, 2);
    expect(speciesNames[0], 'Abei Puffer x1');
    expect(speciesNames[1], 'Acara x2');
  });
}

void speciesNamesJoinedString() {
  test('speciesNamesJoinedString() returns the expected String', () {
    final speciesList = [exampleSpecies, exampleSpecies2, exampleSpecies2];
    final tank = Tank(0, 'Tank Name', 20, speciesList);
    final joinedString = tank.speciesNamesJoinedString();

    expect(joinedString, '3 fish - Abei Puffer x1, Acara x2');
  });
}

void nameTrimmedToLength() {
  test('nameTrimmedToLength() returns the expected String', () {
    final tank = Tank(0, '123456', 20, []);
    expect(tank.nameTrimmedToLength(6), '12345...');
  });
}
