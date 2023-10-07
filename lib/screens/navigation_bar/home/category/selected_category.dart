import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/screens/navigation_bar/home/category/custom_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class SelectCategoryScreen extends StatelessWidget {
  final String category;
  final List<Plant> plants;
  SelectCategoryScreen({required this.category, required this.plants});

  @override
  Widget build(BuildContext context) {
    return SelectCategory(
      category: category,
      plants: plants,
    );
  }
}

class SelectCategory extends StatefulWidget {
  final String category;
  final List<Plant> plants;
  const SelectCategory(
      {super.key, required this.category, required this.plants});

  @override
  SelectCategoryState createState() => SelectCategoryState();
}

class SelectCategoryState extends State<SelectCategory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align to the start (left)
              children: [
                InkWell(
                    onTap: () {
                      context.router.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.category,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF666538)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: MyGridView(
            plants: widget.plants,
          )),
        ]),
      ),
    );
  }
}
