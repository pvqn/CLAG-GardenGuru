import 'package:flutter/material.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/product_list.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/shop_list.dart';

import 'package:google_fonts/google_fonts.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Your main content goes here
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to',
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF666538)),
                      ),
                      Row(
                        children: [
                          // Adding some space between the icon and text
                          Text(
                            '227 Nguyen Van Cu, phuong 4',
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                color: const Color(0xFF666538),
                                fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons
                                .chevron_right, // You can change this to any icon you want
                            color: Color(
                                0xFF666538), // You can change the color of the icon
                          )
                        ],
                      ),
                    ],
                  )),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button click logic here
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Color.fromRGBO(102, 101, 56, 1),
                          width: 2.0,
                        ), // Set the border color and width
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const CircleBorder(),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(
                          8), // Adjust the padding value as needed
                      child: Icon(
                        Icons.assignment_outlined,
                        color: Color(0xFF666538),
                      ),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(25.0), // Rounded corners
                    border: Border.all(
                      color: const Color(0xFF666538)
                          .withOpacity(0.75), // Border color
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
                            hintText: 'What do you need?',
                            hintStyle: GoogleFonts.inter(fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 2, color: const Color(0xFF666538)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/shopping/seed.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Seeds & Bulbs',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('assets/shopping/soil.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Soil & Fertilizers',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/shopping/shovel.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Planting Tools',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/shopping/flowerpots.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Pots & Containers',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/shopping/watering.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Watering & Irrigation',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/shopping/pest-control.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Pest Control',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/shopping/fountain.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Garden Decor',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/shopping/organic-food.png'),
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Organic Products',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF666538),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Just for you!',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF666538)),
                ),
                ShopList(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Hot products',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF666538)),
                ),
                ProductList(shops: [sunflower, npk_fertilizer])
              ],
            ),
          ),
        ),
        // Floating Action Button
        Positioned(
          bottom: 15, // Adjust the position as needed
          right: 15, // Adjust the position as needed
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.shopping_cart),
            backgroundColor:
                const Color(0xFF666538), // Customize button color if needed
          ),
        ),
      ],
    );
  }
}
