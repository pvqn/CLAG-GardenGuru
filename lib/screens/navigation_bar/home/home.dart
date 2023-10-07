import 'package:flutter/material.dart';
import 'package:gardenguru/providers/plant_provider.dart';
import 'package:gardenguru/screens/navigation_bar/home/category_list.dart';
import 'package:gardenguru/screens/navigation_bar/home/post_list.dart';
import 'package:gardenguru/utils/plants_support.dart';
import 'package:provider/provider.dart';

import '../../../models/plant.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: Provider.of<PlantProvider>(context, listen: false).fetchPlants(),
      //plantProvider.fetchPlants(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No plants available.'));
        } else {
          List<Plant> plants = snapshot.data!;

          return Homepage(plants: plants);
        }
      },
    );
  }
}

class Homepage extends StatefulWidget {
  final List<Plant> plants;

  @override
  Homepage({required this.plants});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                'Blossom with nature\nSow green dreams',
                style: GoogleFonts.handlee(
                    textStyle: const TextStyle(
                        color: Color(0xFF666538),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              )),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFF666538),
                    width: 2.0,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: Color(0xFF666538),
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0), // Rounded corners
              border: Border.all(
                color: Color(0xFF666538).withOpacity(0.75), // Border color
                width: 2.0, // Border width
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.search,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Plants',
                      hintStyle: GoogleFonts.inter(fontSize: 15),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Category',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666538))),
          ),
          const SizedBox(
            height: 10,
          ),
          CategoryList(
            plants: widget.plants,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Plant of today',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Color(0xFF666538),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage('assets/plants/6.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(
                            0.3), // Adjust opacity to control darkness
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(widget.plants[6].name,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                        SizedBox(
                          child: Text(widget.plants[6].description,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Recent Posts',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Color(0xFF666538),
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          PostList()
        ]),
      ),
    );
  }
}
