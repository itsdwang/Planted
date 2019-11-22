class Plant {
  String key;
  String plantName;
  String speciesName;
  String lightRequirement;
  String image;

  Plant(key, plantName, speciesName, lightRequirement, image) {
    this.key = key;
    this.plantName = plantName;
    this.speciesName = speciesName;
    this.lightRequirement = lightRequirement;
    this.image = image;
  }

  Plant.fromMap(Map<String, dynamic> map) {
    plantName = map["plantName"];
    speciesName = map["speciesName"];
    lightRequirement = map["lightRequirement"];
    image = map["imageUrl"];
  }

  Plant.fromJson(this.key, Map map) {
    plantName = map["plantName"];
    speciesName = map["speciesName"];
    lightRequirement = map["lightRequirement"];
    image = map["imageUrl"];
  }
}
