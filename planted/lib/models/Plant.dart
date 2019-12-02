class Plant {
  String key;
  String plantName;
  String genusName;
  String lightRequirement;
  String imageUrl;

  Plant(key, plantName, genusName, lightRequirement, image) {
    this.key = key;
    this.plantName = plantName;
    this.genusName = genusName;
    this.lightRequirement = lightRequirement;
    this.imageUrl = image;
  }

  Plant.fromMap(Map<String, dynamic> map) {
    plantName = map["plantName"];
    genusName = map["genusName"];
    lightRequirement = map["lightRequirement"];
    imageUrl = map["imageUrl"];
  }

  Plant.fromJson(this.key, Map map) {
    plantName = map["plantName"];
    genusName = map["genusName"];
    lightRequirement = map["lightRequirement"];
    imageUrl = map["imageUrl"];
  }
}
