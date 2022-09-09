

class Place {
  final String name;
  final String location;

  Place(this.name, this.location);

  Place.fromJson(String key, valu)
      : name = key,
        location = valu.toString().split('/')[2];

}



