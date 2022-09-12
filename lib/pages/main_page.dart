import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trevalapp/models/places.dart';
import 'package:trevalapp/pages/detail_page.dart';
import 'package:trevalapp/repos/cities_repo.dart';
import '../models/cities.dart';
import '../repos/place_repo.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Places();
  }
}

class Places extends ConsumerStatefulWidget {
   Places({Key? key}) : super(key: key);
  City? city;

  @override
  ConsumerState<Places> createState() => _PlacesState();
}

class _PlacesState extends ConsumerState<Places> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<City>> cities = ref.watch(cityListProvider);
    AsyncValue<List<Place>> places = ref.watch(placeListProvider);

    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: const Text('Travel App'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
             DropdownButton<City>(
               value: widget.city,
               items: cities.when(
                   data: (List<City> data) {
                 List<DropdownMenuItem<City>> item = data.map((City city) {
                   return DropdownMenuItem<City>(
                     value: city,
                     child: Text(city.name),
                   );
                 }).toList();
                 return item;
               },
                   loading: () => [],
                    error: (error, stack) => []),
               onChanged: (City? value) {
                 setState(() {
                   widget.city = value;
                 });
               }
             ),
              Expanded(
                child: places.when(
                    data: (List<Place> data) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(data[index].name.trim()),
                              subtitle: Text(data[index].location.trim()),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlaceDetail(
                                              place: data[index],
                                            )));
                              },
                            ),
                            const Divider(
                              height: 2,
                            )
                          ],
                        );
                      });
                },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text(error.toString()))),
              )

            ],
          ),
        ),
      ),
    );

  }
}







