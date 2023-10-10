import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/timeline.dart';
import 'package:gardenguru/providers/post_provider.dart';
import 'package:gardenguru/providers/timeline_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RoutineScreen extends StatelessWidget {
  int index = 0;
  RoutineScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TimelineItem>>(
        future: Provider.of<TimelineProvider>(context, listen: false)
            .fetchTimelineItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const SizedBox(
              height: 2,
            );
          } else {
            List<TimelineItem> timelineitems = snapshot.data!;
            TimelineItem timelineItem = TimelineItem(
                id: 1, name: 'test', timeline: LinkedHashMap<String, String>());
            for (int i = 0; i < timelineitems.length; ++i) {
              if (timelineitems[i].id == index) {
                timelineItem = timelineitems[i];
                break;
              }
            }
            reorderTimelineItems(timelineItem);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  ClipRRect(
                    child: Stack(children: [
                      Container(
                        child: Image.asset(
                          'assets/plants/' +
                              timelineItem.id.toString() +
                              '.jpg', // Replace with your image asset path
                          fit: BoxFit.cover,
                          height: 300,
                          width: double.infinity,
                          // Adjust the height as needed
                        ),
                      ),
                      Positioned(
                          bottom: 20,
                          left: 20,
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 20,
                                right: 20,
                              ),
                              child: Text(
                                timelineItem.name.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                            ),
                          ))
                    ]),
                  ),
                  Align(
                      alignment: Alignment
                          .topLeft, // Align the icons to the top-left corner
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40,
                              left: 20,
                              right: 20), // Add some padding if needed
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
                                ])
                              ])))
                ]),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Watering',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538),
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      WeekViewWidget(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Progress of plant',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color(0xFF666538),
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProgressListView(timelines: timelineItem.timeline)
                    ],
                  ),
                ),
              ],
            );
          }
        });
  }
}

class WeekViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        DateTime day = currentDate
            .subtract(Duration(days: currentDate.weekday - 1))
            .add(Duration(days: index));
        bool isCurrentDay = day.day == currentDate.day;

        return Container(
          width: 50,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: isCurrentDay
                ? Color.fromARGB(255, 194, 193, 160)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              Text(
                _getDayOfWeek(day.weekday),
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
              Text(
                day.day.toString(),
                style: GoogleFonts.inter(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    textStyle: const TextStyle(
                      fontSize: 12,
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              const Icon(
                Icons.water_drop,
                color: Colors.black,
              )
            ],
          ),
        );
      }),
    );
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}

class ProgressListView extends StatelessWidget {
  final LinkedHashMap<String, String> timelines;

  ProgressListView({required this.timelines});

  @override
  Widget build(BuildContext context) {
    // Convert the keys of the LinkedHashMap to a list for indexing
    List<String> timelineKeys = timelines.keys.toList();

    return ListView.builder(
      physics:
          NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
      shrinkWrap: true,
      itemCount: timelines.length,
      itemBuilder: (context, index) {
        String key = timelineKeys[index];
        String value = timelines[key]!; // Accessing the value using the key

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.radio_button_unchecked,
                color: Color(0xFF666538),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$key: $value',
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    textStyle: const TextStyle(
                        color: Color(0xFF666538), fontSize: 14)),
              ) // Displaying both key and value
            ],
          ),
        );
      },
    );
  }
}
