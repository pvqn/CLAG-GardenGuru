import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class GardenGridView extends StatefulWidget {
  final List<Plant> plants;
  const GardenGridView({super.key, required this.plants});

  @override
  State<GardenGridView> createState() => _GardenGridViewState();
}

class _GardenGridViewState extends State<GardenGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 158 / 158,

        crossAxisCount: 2, // Number of columns in the grid
        // Spacing between rows
        // Spacing between columns
      ),
      itemCount: widget.plants.length, // Use the length of your dynamic list
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            context.pushRoute(RoutineRoute(index: widget.plants[index].id));
          },
          child: GridItem(item: widget.plants[index]),
        );
      },
    );
  }
}

class GridItem extends StatefulWidget {
  final Plant item;

  const GridItem({super.key, required this.item});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 158,
      height: 158, // Set a fixed height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4), // Adjust opacity to control darkness
            BlendMode.darken,
          ),
          image:
              AssetImage('assets/plants/' + widget.item.id.toString() + '.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.item.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2)))
            ],
          ),
        ),
      ),
    );
  }
}
