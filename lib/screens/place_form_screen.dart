import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_flutter/providers/great_places.dart';
import 'package:places_flutter/widgets/image_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Título'),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _submitForm,
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
