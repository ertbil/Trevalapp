import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trevalapp/models/cities.dart';
import 'package:trevalapp/services/json_converter.dart';


class CityRepo extends ChangeNotifier{
  List<City> cities = [];

  final Converter converter;

  CityRepo(this.converter);


  Future<List<City>> getAll() async {
    cities = await converter.cityDecoder();
    notifyListeners();
    return cities;

  }

}

final ChangeNotifierProvider<CityRepo> cityProvider = ChangeNotifierProvider((ref) {

  return CityRepo(ref.watch(converterProvider));
},
);

final FutureProvider<List<City>> cityListProvider = FutureProvider( (ref)  async{
  return ref.read(converterProvider).cityDecoder();

}
);
