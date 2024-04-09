import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/utils/file_system.dart';
import 'package:poke_app/views/views.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String getAssetImage(String type, String name) {
  return "assets/${type}_types/$name.png";
}

Widget buildCategoryFromContext(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Pokemon pokemon = arguments["pokemon"] as Pokemon;
    final String category = arguments["category"] as String;
    return Category(pokemon: pokemon, category: category);
}

Future<void> _checkPermissions() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (!cameraPermissionStatus.isGranted) {
      await Permission.camera.request();
    }
    PermissionStatus storagePermissionStatus =
        await Permission.storage.status;
    if (!storagePermissionStatus.isGranted) {
      await Permission.storage.request();
    }
  }

Future<String> takePicture(String pokemonName) async {
  try {
    final picker = ImagePicker();
    await _checkPermissions();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Directory capturesDirectory = await FileSystemUtils.createLocalDirectory(pokemonName.toLowerCase());
      String fileName = basename(pickedFile.path);
      String newFilePath = '${capturesDirectory.path}$fileName';

      File sourceFile = File(pickedFile.path);
      File newFile = File(newFilePath);
      await newFile.writeAsBytes(await sourceFile.readAsBytes());
      return "Image saved into device storage.";
    } else {
      return "";
    }
  } catch (e) {
    return e.toString();
  }
}