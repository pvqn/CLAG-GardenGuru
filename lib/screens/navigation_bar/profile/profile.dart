import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/models/post.dart';
import 'package:gardenguru/models/timeline.dart';
import 'package:gardenguru/providers/plant_provider.dart';
import 'package:gardenguru/providers/post_provider.dart';
import 'package:gardenguru/providers/timeline_provider.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:gardenguru/screens/navigation_bar/home/post_list.dart';
import 'package:gardenguru/screens/navigation_bar/profile/garden_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/plants/6.jpg'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'antihcmus',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF666538)),
                          ),
                          Text(
                            'Joined from October 3rd, 2023',
                            style: GoogleFonts.inter(
                                fontSize: 14, color: const Color(0xFF666538)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _signOut();
                    context.router.push(SignUpRoute());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const CircleBorder(
                        side: BorderSide(color: Color(0xFF666538), width: 2.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(
                          18.0), // Adjust the padding as needed
                    ),
                  ),
                  child: const Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF666538),
                    size: 24,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.router.push(AddPostRoute());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF666538)), // Set background color
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ), // Set padding
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Set border radius
                      ),
                    ), // Set border shape
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white)), // Set text style
                    ), // Set text style
                  ),
                  child: const Text('Add a post'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _buildTabsContent()
          ],
        ),
      ),
    );
  }
}

Widget _buildTabsContent() {
  return Expanded(
    child: Column(
      children: [
        Container(
          width: double.infinity,
          child: TabBar(
            labelColor: const Color(0xFF666538),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: const Color(0xFF666538),
            labelStyle: GoogleFonts.inter(
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Reposts'),
              Tab(text: 'Garden'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [PostsTab(), RepostsTab(), GardenTab()],
          ),
        ),
      ],
    ),
  );
}

class PostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: Provider.of<PostProvider>(context, listen: false).fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available.'));
          } else {
            List<Post> posts = snapshot.data!;

            return PostList(
              posts: posts.reversed.toList(),
            );
          }
        });
  }
}

class RepostsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future:
            Provider.of<RepostProvider>(context, listen: false).fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts  available.'));
          } else {
            List<Post> posts = snapshot.data!;

            return PostList(
              posts: posts.reversed.toList(),
            );
          }
        });
  }
}

class GardenTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
        future: Provider.of<GardenProvider>(context, listen: false)
            .fetchGardenNumbers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No timeline available.'));
          } else {
            List<int> timelineitems = snapshot.data!;
            // for (var item in timelineitems) {
            //   print(item.toString() + ', ');
            // }

            return FutureBuilder<List<Plant>>(
                future: Provider.of<PlantProvider>(context, listen: false)
                    .fetchPlants(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No timeline available.'));
                  } else {
                    List<Plant> plants = snapshot.data!;
                    List<Plant> temp = [];
                    for (int i = 0; i < timelineitems.length; ++i) {
                      for (int j = 0; j < plants.length; ++j) {
                        if (plants[j].id == timelineitems[i]) {
                          temp.add(plants[j]);
                        }
                      }
                    }
                    return GardenGridView(
                      plants: temp,
                    );
                  }
                });
          }
        });
  }
}
