import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class MyGridView extends StatefulWidget {
  final List<Plant> plants;
  const MyGridView({super.key, required this.plants});

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
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
            context.pushRoute(PlantRoute(plant: widget.plants[index]));
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

    // return Container(
    //   margin: EdgeInsets.all(10),
    //   width: 158,
    //   height: 280, // Set a fixed height
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10.0),
    //     image: DecorationImage(
    //       image: item.imageId != null
    //           ? NetworkImage('http://52.195.170.49:8888/asset/${item.imageId}')
    //               as ImageProvider
    //           : const AssetImage('assets/images/food.png'),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.only(bottom: 140),
    //                 width: double.infinity, // Expand to full width
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     Expanded(child: Text('')),
    //                     Icon(
    //                       Icons.favorite,
    //                       size: 20,
    //                       color: Colors.white,
    //                     ),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     Text(item.numLiked.toString(),
    //                         style: GoogleFonts.poppins(
    //                             textStyle: TextStyle(
    //                                 fontSize: 13,
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.bold))),
    //                     SizedBox(
    //                       width: 8,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 // Wrap text with a Container
    //                 width: double.infinity, // Expand to full width
    //                 child: Text(snapshot ?? 'Greek Yogurt with Chia Pudding',
    //                     style: GoogleFonts.inter(
    //                         textStyle: TextStyle(
    //                             fontSize: 15,
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.bold))),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               Container(
    //                 // Wrap text with a Container
    //                 width: double.infinity, // Expand to full width
    //                 child: Row(
    //                   children: [
    //                     CircleAvatar(
    //                       radius: 10,
    //                       backgroundImage:
    //                           AssetImage('assets/images/welcome_bg.png'),
    //                     ),
    //                     SizedBox(width: 5),
    //                     Text(item.author ?? 'antihcmus',
    //                         style: GoogleFonts.poppins(
    //                             textStyle: TextStyle(
    //                                 fontSize: 13,
    //                                 color: Colors.white,
    //                                 fontWeight: FontWeight.w500))),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //             ],
    //           ),
    //         ),
    // );
  }
}
