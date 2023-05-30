import 'package:flutter/material.dart';
import 'package:places_flutter/providers/great_places.dart';
import 'package:places_flutter/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PLACE_FORM,
              );
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (ctx, greatePlaces, ch) => greatePlaces.itemsCount == 0
            ? ch!
            : ListView.builder(
                itemCount: greatePlaces.itemsCount,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatePlaces.itemByIndex(i).image,
                    ),
                  ),
                  title: Text(greatePlaces.itemByIndex(i).title),
                  onTap: () {},
                ),
              ),
        child: const Center(
          child: Text('Nenhm Local Cadastrado!'),
        ),
      ),
    );
  }
}
