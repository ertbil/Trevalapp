import 'package:flutter/material.dart';
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
  City? city;

   Places({
    Key? key,
  }) : super(key: key);

   @override
  ConsumerState<Places> createState() => _PlacesState();

}
class _PlacesState extends ConsumerState<Places> {

  @override
  Widget build(BuildContext context) {
    final citiesRepo = ref.watch(cityProvider);
    final placesRepo = ref.watch(placeProvider);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Treval App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
       children: [
        DropdownButton(
            items: citiesRepo.cities.map((City city) {
              return DropdownMenuItem(
                value: city,
                child: Text(city.name),
              );
            }).toList(),
            onChanged: (City? value) {
              setState(() {
                widget.city = value;
              });
            },
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final AsyncValue<List<Place>> places = ref.watch(placeListProvider);
              return places.when(
                  data: (places) {
                    return ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(places[index].name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaceDetail(
                                  place: places[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => const Center(
                    child: Text('Error'),
                  ));
            },
          ),
        ),
        ],
      ),
    );

  }
}
class PlaceRow extends ConsumerWidget {
  final Place place;
  const PlaceRow(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(place.name),
      subtitle: Text(place.location),

    );
  }
}




