import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:places_flutter/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];
  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];
  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: const PlaceLocation(
        latitude: 0,
        longitude: 0,
      ),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
