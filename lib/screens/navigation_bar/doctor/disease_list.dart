import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/disease.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseListView extends StatefulWidget {
  final List<Disease> diseases;
  const DiseaseListView({required this.diseases});

  @override
  State<DiseaseListView> createState() => _DiseaseListViewState();
}

class _DiseaseListViewState extends State<DiseaseListView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 158 / 180,

        crossAxisCount: 2, // Number of columns in the grid
        // Spacing between rows
        // Spacing between columns
      ),
      itemCount: widget.diseases.length, // Use the length of your dynamic list
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            context.pushRoute(DiseaseRoute(item: widget.diseases[index]));
          },
          child: GridItem(item: widget.diseases[index]),
        );
      },
    );
  }
}

class GridItem extends StatefulWidget {
  final Disease item;

  const GridItem({super.key, required this.item});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: 158,
          height: 158, // Set a fixed height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black
                    .withOpacity(0.4), // Adjust opacity to control darkness
                BlendMode.darken,
              ),
              image: AssetImage(
                  'assets/disease/' + widget.item.index.toString() + '.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(widget.item.diseaseName,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
              fontSize: 15,
              color: Color(0xFF666538),
              fontWeight: FontWeight.w500,
            ))),
      ],
    );
  }
}
