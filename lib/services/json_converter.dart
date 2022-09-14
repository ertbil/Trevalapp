import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cities.dart';
import '../models/places.dart';

class Converter {


     Future<List<City>> cityDecoder() async {
      final String response = await rootBundle.loadString('datas/cities.json');
      if(response != null) {
        final Map<String, dynamic> data = json.decode(response);
        final List<City> cities = [];
        for (int i = 0; i < data.length; i++) {
          City city = City.fromJson(data,i);
          cities.add(city);
        }
        return cities;
      } else {
        throw Exception('Cities download ended with failure');
      }

  }

  Future<List<Place>> placeDecoder() async {
       final String response = await rootBundle.loadString('datas/datas.json');
       if(response != null) {
         final Map<String, dynamic> data = json.decode(response);
         final List<Place> places = [];
         var keys = data.keys.toList();
          for (int i = 0; i < data.length; i++) {
            Place place = Place.fromJson(data, keys[i]);
            places.add(place);
          }

         return places;
       } else {
         throw Exception('Places download ended with failure');
       }
  }


}
final converterProvider = Provider((ref) => Converter());