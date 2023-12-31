import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gardenguru/firebase_options.dart';
import 'package:gardenguru/providers/disease_provider.dart';
import 'package:gardenguru/providers/maintenance_provider.dart';
import 'package:gardenguru/providers/post_provider.dart';
import 'package:gardenguru/providers/province_provider.dart';
import 'package:gardenguru/providers/timeline_provider.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gardenguru/providers/plant_provider.dart';
import 'package:gardenguru/providers/weather_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PlantProvider()),
      ChangeNotifierProvider(create: (_) => ProvinceProvider()),
      ChangeNotifierProvider(create: (_) => MaintenanceProvider()),
      ChangeNotifierProvider(create: (_) => DiseaseProvider()),
      ChangeNotifierProvider(create: (_) => RepostProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ChangeNotifierProvider(create: (_) => TimelineProvider()),
      ChangeNotifierProvider(create: (_) => GardenProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
