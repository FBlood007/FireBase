import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FireBase(),
      )
  );
}
