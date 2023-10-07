import 'package:auto_route/auto_route.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/product_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'shop_list.dart';

@RoutePage()
class ShopScreen extends StatelessWidget {
  Shop shop;
  ShopScreen({required this.shop});
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
                child: Image.asset(
                  shop.image, // Replace with your image asset path
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                shop.name,
                style: GoogleFonts.poppins(
                    textStyle:
                        const TextStyle(fontSize: 24, color: Color(0xFF666538)),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.pin_drop,
                    color: Color(0xFF666538),
                  ),
                  Text(shop.address,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF666538),
                              fontWeight: FontWeight.w500)))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'About us',
                style: GoogleFonts.poppins(
                    textStyle:
                        const TextStyle(fontSize: 18, color: Color(0xFF666538)),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                shop.description,
                style: GoogleFonts.poppins(
                  textStyle:
                      const TextStyle(fontSize: 13, color: Color(0xFF666538)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Color(0xFF666538),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Products',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ProductList(
                shops: shop.items,
              ),
              const SizedBox(
                height: 30,
              ),
            ]),
          )
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
