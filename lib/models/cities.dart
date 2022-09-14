class City {
  String name;

  City({required this.name});
  City.fromJson(Map<String, dynamic> json, int plateID) : name = json[plateID.toString()];

}
