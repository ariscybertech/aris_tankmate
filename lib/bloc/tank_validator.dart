import 'package:tank_mates/data/model/tank_state.dart';

class TankValidator {
  bool isValidTank(TankState tank) {
    if (!isValidTemperature(tank) ||
        !isValidPh(tank) ||
        !isValidHardness(tank)) {
      return false;
    }

    return true;
  }

  bool isTankOverstocked(TankState tank) {
    return tank.percentFilled > 130;
  }

  bool isValidTemperature(TankState tank) {
    return tank.tempMin <= tank.tempMax;
  }

  bool isValidPh(TankState tank) {
    return tank.phMin <= tank.phMax;
  }

  bool isValidHardness(TankState tank) {
    return tank.hardnessMin <= tank.hardnessMax;
  }
}
