class Plant {
  String key;
  String plantName;
  String genusName;
  String lightRequirement;
  String imageUrl;

  /// Constructor to store user's input values to add plant form.
  Plant(key, plantName, genusName, lightRequirement, image) {
    this.key = key;
    this.plantName = plantName;
    this.genusName = genusName;
    this.lightRequirement = lightRequirement;
    this.imageUrl = image;
  }

  /// Places values from map structure to the Plant variables.
  Plant.fromMap(Map<String, dynamic> map) {
    plantName = map["plantName"];
    genusName = map["genusName"];
    lightRequirement = map["lightRequirement"];
    imageUrl = map["imageUrl"];
  }

  /// Creates a new Plant instance from a map structure.
  Plant.fromJson(this.key, Map map) {
    plantName = map["plantName"];
    genusName = map["genusName"];
    lightRequirement = map["lightRequirement"];
    imageUrl = map["imageUrl"];
  }
}
