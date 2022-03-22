import 'package:dukka/app/app.dart';
import 'package:dukka/bootstrap.dart';
import 'package:dukka/core/injections/locator.dart';
import 'package:dukka/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependecies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(() => const App());
}
