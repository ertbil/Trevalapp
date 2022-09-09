import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trevalapp/models/places.dart';
import 'package:trevalapp/services/json_converter.dart';


class PlaceRepo extends ChangeNotifier{
  List<Place> places = [


  ];

  final Converter converter;

  PlaceRepo(this.converter);


  Future<List<Place>> getAll() async {
    places = await converter.placeDecoder();
    notifyListeners();
    return places;

  }

}

final placeProvider = ChangeNotifierProvider((ref) {

  return PlaceRepo(ref.watch(converterProvider));
},);

final placeListProvider = FutureProvider((ref) => ref.watch(placeProvider).getAll());
