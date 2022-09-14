import 'package:trevalapp/util/string_extensions.dart';



const String baseURL = "https://kulturportali.gov.tr/";
const List<String> onNullList = ['Unknown'];


class Place {
  final String slug;
  final String name;
  final String location;
  final String image;
  final String type;
  final String tourismType;
  final String adress;
  final String directions;
  final String sourceURL;
  final List<dynamic> tags;
  final String content;


  Place(
      this.slug,
      this.name,
      this.location,
      this.image,
      this.type,
      this.tourismType,
      this.adress,
      this.directions,
      this.sourceURL,
      this.tags,
      this.content);

  Place.fromJson(Map<String, dynamic> json, String key)
      : slug = json[key]['slug']??"Unknown",
        name = json[key]['name']??'Unknown',
        location = json[key]['city_name']??'Unknown',
        image = json[key]['preview_image'] != null?baseURL+ json[key]['preview_image']:"Image not found",
        type = json[key]['detaylar'] != null ? json[key]['detaylar']["Tür"] ?? "Unknown":'Unknown',
        tourismType = json[key]['detaylar'] != null ?json[key]['detaylar']["Turizm Türü"]??'Unknown':'Unknown',
        adress = json[key]['detaylar'] != null ? json[key]['detaylar']["Adres"] ?? 'Unknown' : 'Unknown',
        directions = json[key]['detaylar'] != null ? json[key]['detaylar']["Nasıl Gidilir"] ?? 'Unknown':'Unknown',
        sourceURL = json[key]['source_url'] != null ? baseURL+json[key]['source_url'] : "Source not found",
        tags = json[key]['tags'] ?? onNullList,
        content = json[key]['content'] ?? 'Unknown';

}





