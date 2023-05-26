import 'package:flutter/foundation.dart';
import 'package:places_flutter/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];
  int get itemsCount => _items.length;

  Place itemByIndex(int index) => _items[index];
}
