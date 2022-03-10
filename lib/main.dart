import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FireBase(),
      )
  );
}
