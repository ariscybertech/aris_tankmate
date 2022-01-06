class SpeciesJsonData {
  String name;
  String scientificName;
  String speciesGroup;
  String aggressiveness;
  String phRange;
  String temperatureRange;
  String hardness;
  String careLevel;
  String maximumAdultSize;
  String diet;
  String minTankSize;

  SpeciesJsonData(
      this.name,
      this.scientificName,
      this.speciesGroup,
      this.aggressiveness,
      this.phRange,
      this.temperatureRange,
      this.hardness,
      this.careLevel,
      this.maximumAdultSize,
      this.diet,
      this.minTankSize);

  factory SpeciesJsonData.fromJson(dynamic json) {
    return SpeciesJsonData(
      json['name'] as String,
      json['scientificName'] as String,
      json['speciesGroup'] as String,
      json['aggressiveness'] as String,
      json['phRange'] as String,
      json['temperatureRange'] as String,
      json['hardness'] as String,
      json['careLevel'] as String,
      json['maximumAdultSize'] as String,
      json['diet'] as String,
      json['minTankSize'] as String,
    );
  }

  @override
  String toString() {
    return 'Fish{name: $name, scientificName: $scientificName, speciesGroup: $speciesGroup, aggressiveness: $aggressiveness, phRange: $phRange, temperatureRange: $temperatureRange, hardness: $hardness, careLevel: $careLevel, maximumAdultSize: $maximumAdultSize, diet: $diet, minTankSize: $minTankSize}';
  }
}
