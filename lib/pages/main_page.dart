import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trevalapp/models/places.dart';
import 'package:trevalapp/pages/detail_page.dart';
import 'package:trevalapp/pages/setting_page.dart';
import 'package:trevalapp/repos/cities_repo.dart';
import 'package:trevalapp/util/string_extensions.dart';
import '../components/cardview.dart';
import '../components/drawer.dart';
import '../components/listview.dart';
import '../models/cities.dart';
import '../repos/place_repo.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Places();
  }
}

// ignore: must_be_immutable
class Places extends ConsumerStatefulWidget {
  City? city;
  bool isCardView = true;

  Places({Key? key}) : super(key: key);

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
        appBar: AppBar(
          title: const Text('Travel App'),
          centerTitle: true,
        ),
        drawer: const UserDrawer(),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  DropdownButton<City>(
                      icon: const Icon(Icons.arrow_drop_down),
                      value: widget.city ?? cities.asData?.value.first,
                      items: cities.when(
                          data: (List<City> data) {
                            List<DropdownMenuItem<City>> item =
                                data.map((City city) {
                              return DropdownMenuItem<City>(
                                value: city,
                                child: Text(city.name.capitalize()),
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
                      }),
                  const Spacer(),
                  Icon(
                      color: Colors.blue,
                      widget.isCardView ? Icons.grid_view : Icons.list),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: Switch(
                        value: widget.isCardView,
                        onChanged: (bool value) {
                          setState(() {
                            widget.isCardView = value;
                          });
                        }),
                  ),
                ],
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(placeListProvider);
                },
                child: places.when(
                  data: (List<Place> data) {
                    List<Place> filteredPlaces = data.where((Place place) {
                      if (widget.city == null) {
                        return true;
                      } else if (widget.city!.name == "Hepsini Göster") {
                        return true;
                      } else {
                        return place.location.toLowerCase().trim() ==
                            widget.city!.name.trim().toLowerCase();
                      }
                    }).toList();
                    return widget.isCardView
                        ? Cards(filteredPlaces: filteredPlaces)
                        : ListRow(filteredPlaces: filteredPlaces);
                  },
                  error: (error, stack) => const Text('Error'),
                  loading: () => const CircularProgressIndicator(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
