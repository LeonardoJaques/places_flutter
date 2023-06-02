import 'package:flutter/material.dart';
import 'package:places_flutter/providers/great_places.dart';
import 'package:places_flutter/screens/place_detail_screen.dart';
import 'package:places_flutter/screens/place_form_screen.dart';
import 'package:places_flutter/screens/place_list_screen.dart';
import 'package:places_flutter/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.PLACE_FORM: (ctx) => const PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (ctx) => const PlaceDetailScreen(),
        },
        home: const PlacesListScreen(),
      ),
    );
  }
}
