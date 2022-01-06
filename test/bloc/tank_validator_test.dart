import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/bloc/tank_validator.dart';
import 'package:tank_mates/data/model/tank_state.dart';

void main() {
  testIsValidTemperature();
  testIsValidPh();
  testIsValidHardness();
}

void testIsValidTemperature() {
  final TankValidator tankValidator = TankValidator();

  final TankState defaultTank = TankState();

  final TankState validTank = TankState();
  validTank.tempMin = 75;
  validTank.tempMax = 85;

  final TankState invalidTank = TankState();
  invalidTank.tempMin = 75;
  invalidTank.tempMax = 65;

  test('isValidTemperature returns true for a new Tank object', () {
    bool isValid = tankValidator.isValidTemperature(defaultTank);
    expect(isValid, true);
  });

  test(
      'isValidTemperature returns true for a Tank with a tempMin lower than tempMax',
      () {
    bool isValid = tankValidator.isValidTemperature(validTank);
    expect(isValid, true);
  });

  test(
      'isValidTemperature returns false for a Tank with a tempMin greater than tempMax',
      () {
    bool isValid = tankValidator.isValidTemperature(invalidTank);
    expect(isValid, false);
  });
}

void testIsValidPh() {
  final TankValidator tankValidator = TankValidator();

  final TankState defaultTank = TankState();

  final TankState validTank = TankState();
  validTank.phMin = 6.0;
  validTank.phMax = 8.0;

  final TankState invalidTank = TankState();
  invalidTank.phMin = 8.0;
  invalidTank.phMax = 6.0;

  test('isValidPh returns true for a new Tank object', () {
    bool isValid = tankValidator.isValidPh(defaultTank);
    expect(isValid, true);
  });

  test('isValidPh returns true for a Tank with a phMin lower than phMax', () {
    bool isValid = tankValidator.isValidPh(validTank);
    expect(isValid, true);
  });

  test('isValidPh returns false for a Tank with a phMin greater than phMax',
      () {
    bool isValid = tankValidator.isValidPh(invalidTank);
    expect(isValid, false);
  });
}

void testIsValidHardness() {
  final TankValidator tankValidator = TankValidator();

  final TankState defaultTank = TankState();

  final TankState validTank = TankState();
  validTank.hardnessMin = 10;
  validTank.hardnessMax = 20;

  final TankState invalidTank = TankState();
  invalidTank.hardnessMin = 20;
  invalidTank.hardnessMax = 10;

  test('isValidHardness returns true for a new Tank object', () {
    bool isValid = tankValidator.isValidHardness(defaultTank);
    expect(isValid, true);
  });

  test(
      'isValidHardness returns true for a Tank with a hardnessMin lower than hardnessMax',
      () {
    bool isValid = tankValidator.isValidHardness(validTank);
    expect(isValid, true);
  });

  test(
      'isValidHardness returns false for a Tank with a hardnessMin greater than hardnessMax',
      () {
    bool isValid = tankValidator.isValidHardness(invalidTank);
    expect(isValid, false);
  });
}
