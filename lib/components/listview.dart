import 'package:flutter/material.dart';

import '../models/places.dart';
import '../pages/detail_page.dart';

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