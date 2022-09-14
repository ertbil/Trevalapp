import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trevalapp/models/places.dart';
import 'package:trevalapp/pages/detail_page.dart';
import 'package:trevalapp/pages/setting_page.dart';
import 'package:trevalapp/repos/cities_repo.dart';
import 'package:trevalapp/util/string_extensions.dart';
import '../models/cities.dart';
import '../repos/place_repo.dart';
import 'login_screen.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Places();
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

        appBar:AppBar(
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
                  Spacer(),
                  DropdownButton<City>(
                    icon: const Icon(Icons.arrow_drop_down),
                    value: widget.city ?? cities.asData?.value.first,
                    items:  cities.when(
                        data: (List<City> data) {
                          List<DropdownMenuItem<City>> item = data.map((City city) {
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
                    }
                  ),
                  Spacer(),
                  Icon(
                      color: Colors.blue,
                      widget.isCardView ? Icons.grid_view: Icons.list
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: Switch(value: widget.isCardView, onChanged: (bool value) {
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
                        if(widget.city == null) {
                          return true;
                        }
                        else if(widget.city!.name == "Hepsini Göster") {
                          return true;
                        }
                        else {
                          return place.location.toLowerCase().trim() == widget.city!.name.trim().toLowerCase();
                        }
                      }).toList();
                      return widget.isCardView? Cards(filteredPlaces: filteredPlaces): ListRow(filteredPlaces: filteredPlaces);
                    },
                    error: (error, stack) => const Text('Error'),
                    loading: () => const CircularProgressIndicator(),

                  ),
                )
            ),

            ],
          ),
        ),
      ),
    );

  }
}

class Cards extends StatefulWidget {
   bool isLiked = false;

   Cards({Key? key,
  required this.filteredPlaces
  }) : super(key: key);
  final List<Place> filteredPlaces;

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.filteredPlaces.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceDetail(place: widget.filteredPlaces[index],)));
            },
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(widget.filteredPlaces[index].image, fit: BoxFit.cover,),
                  ),

                  Text(widget.filteredPlaces[index].name.trim(), style: const TextStyle(fontSize: 17,),textAlign: TextAlign.center),
                  Text(widget.filteredPlaces[index].location, style: const TextStyle(fontSize: 15), textAlign: TextAlign.center,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon( widget.isLiked? Icons.favorite: Icons.favorite_border,
                        color:  widget.isLiked? Colors.red: Colors.grey),
                        onPressed: () {

                        },
                      ),
                      IconButton(
                          icon: const Icon(Icons.arrow_forward_outlined)
                          , onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceDetail(place: widget.filteredPlaces[index],)));
                          })
                    ],
                  )
                ],
              ),
            ),
          );
        });

  }
}


class ListRow extends StatelessWidget {
  const ListRow({
    Key? key,
    required this.filteredPlaces,
  }) : super(key: key);

  final List<Place> filteredPlaces;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: filteredPlaces.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading:  SizedBox(
            width: 50,
            height: 50,
            child: Image.network(filteredPlaces[index].image),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  //TODO : Add to favorite
                },
                icon: const Icon(Icons.favorite_border_outlined),

              ),

              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetail(
                        place: filteredPlaces[index],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward_outlined),
              ),

            ],
          ),
          title: Text(filteredPlaces[index].name.trim()),
          subtitle: Text(filteredPlaces[index].location.trim()),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceDetail(
                  place: filteredPlaces[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 40,
                 child: Icon(Icons.person, size: 50,),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("User Name", style: TextStyle(color: Colors.white,fontSize: 20) ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: () {
              Navigator.of(context).push(_createRoute(const LogInPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(_createRoute(const SettigPage()));
            },
          ),
        ],
      ),
    );
  }
}

Route _createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}









