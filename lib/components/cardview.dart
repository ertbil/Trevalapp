import 'package:flutter/material.dart';
import 'package:trevalapp/components/image_controller.dart';

import '../models/places.dart';
import '../pages/detail_page.dart';

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
                    child: imageController(widget.filteredPlaces[index].image),

                  ),

                  Text(widget.filteredPlaces[index].name.trim(),
                      style: const TextStyle(fontSize: 17,),
                      textAlign: TextAlign.center),
                  Text(widget.filteredPlaces[index].location,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,),
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