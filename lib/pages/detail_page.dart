import 'package:flutter/material.dart';
import 'package:trevalapp/models/places.dart';

class PlaceDetail extends StatelessWidget {
  final Place place;
  const PlaceDetail({Key? key,  required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(place.name),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 35
            ),

             Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: MediaQuery.of(context).size.width*0.45,
                  child: Image.network(place.image)),
              ),
            const SizedBox(
              height: 35
            ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Spacer(),
                  Icon(Icons.favorite_border_outlined),
                  Spacer(),
                  Icon(Icons.share),
                  Spacer(),

                ],

              ),
            const SizedBox(

              height: 15,
            ),

            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title:  Text(place.location),
                    subtitle: const Text("Location"),
                  ),
                   ListTile(
                    title:  Text(place.type),
                    subtitle: Text("Type"),
                  ),
                    ListTile(
                      title:  Text(place.tourismType),
                      subtitle: const Text("Tourism Type"),
                    ),
                    ListTile(
                      title:  Text(place.adress),
                      subtitle: const Text("Adress"),
                    ),
                    ListTile(
                      title:  Text(place.directions),
                      subtitle: const Text("Directions"),
                    ),


                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
