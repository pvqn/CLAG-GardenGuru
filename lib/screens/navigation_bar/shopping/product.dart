import 'package:auto_route/auto_route.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/product_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:counter_button/counter_button.dart';
import 'shop_list.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  Item item;
  ProductScreen({required this.item});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _counterValue = 0;

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
                  widget.item.image, // Replace with your image asset path
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.item.name,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 24, color: Color(0xFF666538)),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('\$' + widget.item.price.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFF666538),
                              fontWeight: FontWeight.bold))),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.item.imageShop),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.nameShop,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF666538))),
                      ),
                      Text(
                        '227 Nguyen Van Cu, phuong 4, quan 5',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF666538))),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'About product',
                style: GoogleFonts.poppins(
                    textStyle:
                        const TextStyle(fontSize: 18, color: Color(0xFF666538)),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.item.description,
                style: GoogleFonts.poppins(
                  textStyle:
                      const TextStyle(fontSize: 13, color: Color(0xFF666538)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CounterButton(
                    loading: false,
                    onChange: (int val) {
                      setState(() {
                        _counterValue = val;
                      });
                    },
                    count: _counterValue,
                    countColor: const Color(0xFF666538),
                    buttonColor: const Color(0xFF666538),
                    progressColor: const Color(0xFF666538),
                  ),
                  const Expanded(child: Text('')),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              16.0), // Same as ClipRRect radius
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF666538)),
                      ),
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 20, left: 20),
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                        ),
                      ))
                ],
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
