import 'package:auto_route/auto_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';

import '../../../models/disease.dart';

@RoutePage()
class DiseaseScreen extends StatefulWidget {
  Disease item;
  DiseaseScreen({required this.item});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Three tabs: Summary, Ingredients, and Directions
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context), // Back icon and image
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Column(children: [
          ClipRRect(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black
                    .withOpacity(0.5), // Adjust the color and opacity as needed
                BlendMode
                    .srcATop, // BlendMode to control how the color will blend with the image
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
                child: Image.asset(
                  'assets/disease/' +
                      widget.item.index.toString() +
                      '.jpg', // Replace with your image asset path
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
                  // Adjust the height as needed
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.diseaseName,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 24, color: Color(0xFF666538)),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'About the disease',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 20, color: Color(0xFF666538)),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                createBulletPointsText(widget.item.description),
                const SizedBox(height: 10),
                Text(
                  'Possible solution',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 20, color: Color(0xFF666538)),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                createBulletPointsText(widget.item.description),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ]),
        Align(
          alignment:
              Alignment.topLeft, // Align the icons to the top-left corner
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 20, right: 20), // Add some padding if needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        context.router.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(child: Text('')),
                    const Icon(
                      Icons.more_vert,
                      size: 24,
                      color: Colors.white,
                    )
                  ]),
                ],
              )),
        ),
      ],
    );
  }
}

RichText createBulletPointsText(String input) {
  List<String> lines = input.split('\n');

  List<TextSpan> textSpans = [];
  for (String line in lines) {
    if (line.isNotEmpty) {
      textSpans.add(
        TextSpan(
          text: '\u2022 ', // Unicode character for bullet point
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666538)),
          ),
        ),
      );
    }
    textSpans.add(
      TextSpan(
        text: line + '\n',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666538)),
        ),
      ),
    );
  }

  return RichText(
    text: TextSpan(
        children: textSpans,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666538)),
        )),
  );
}
