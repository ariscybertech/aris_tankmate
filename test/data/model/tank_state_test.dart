import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/data/model/tank_state.dart';

void main() {
  defaultValues();
  hasSpecies();
}

void defaultValues() {
  test('TankState() instantiates with the expected defaults', () {
    final state = TankState();

    expect(state.id, -1);
    expect(state.tankName, 'Tank Name');
    expect(state.gallons, 20);
    expect(state.status, TankStatus.Good);
    expect(state.aggressiveness, Aggressiveness.peaceful);
    expect(state.phMin, 0.0);
    expect(state.phMax, 14.0);
    expect(state.tempMin, 0);
    expect(state.tempMax, 100);
    expect(state.hardnessMin, 0);
    expect(state.hardnessMax, 100);
    expect(state.careLevel, CareLevel.easy);
    expect(state.percentFilled, 0);
    expect(state.recommendationList, ['Add some fish to your tank!']);
    expect(state.speciesAdded, []);
  });
}

void hasSpecies() {
  test('hasSpecies() returns the correct value', () {
    final state = TankState();
    expect(state.speciesAdded, []);
    expect(state.hasSpecies(), false);

    state.speciesAdded = [Species.empty()];
    expect(state.hasSpecies(), true);
  });
}
