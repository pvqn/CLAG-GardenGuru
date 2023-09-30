import 'package:flutter/material.dart';
import 'package:gardenguru/firebase_options.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gardenguru/providers/plant_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlantProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}

class PlantListWidget extends StatefulWidget {
  @override
  State<PlantListWidget> createState() => _PlantListWidgetState();
}

class _PlantListWidgetState extends State<PlantListWidget> {
  @override
  Widget build(BuildContext context) {
    var plantProvider = Provider.of<PlantProvider>(context);

    return FutureBuilder<List<Plant>>(
      future: plantProvider.fetchPlants(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No plants available.'));
        } else {
          List<Plant> plants =
              snapshot.data!; // Get the list of plants from snapshot.data

          return ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              var plant = plants[index];
              return ListTile(
                title: Text(plant.name),
                subtitle: Text(plant.description),
              );
            },
          );
        }
      },
    );
  }
}
