import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:gardenguru/utils/plants_support.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  final List<String> categories = [
    'Any',
    'Fruit',
    'Flower',
    'Herb',
    'Vegetable'
  ];
  final List<Plant> plants;
  CategoryList({required this.plants}); // Constructor

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushRoute(SelectCategoryRoute(
                  category: widget.categories[index].toString(),
                  plants:
                      findByCategory(widget.plants, widget.categories[index])));
            },
            child: CategoryItem(
              text: widget.categories[index],
              id: index.toString(),
            ),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatefulWidget {
  final String text;
  final String id;

  const CategoryItem({
    super.key,
    required this.text,
    this.id = '',
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          // Background Image loaded from API
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('assets/category/' + widget.id + '.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black
                      .withOpacity(0.5), // Adjust opacity to control darkness
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            left: 5,
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      widget.text,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
