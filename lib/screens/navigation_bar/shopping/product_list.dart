import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:gardenguru/screens/navigation_bar/shopping/shop_list.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatefulWidget {
  List<Item> shops;
  ProductList({required this.shops});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.shops.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushRoute(ProductRoute(item: widget.shops[index]));
            },
            child: ProductItem(item: widget.shops[index]),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  Item item;

  ProductItem({required this.item});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.2)),
          color: Colors.amber.shade200.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(right: 20, top: 10),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(widget.item.image), fit: BoxFit.cover)),
          ),
          Container(
            width: 150,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.item.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.inter(
                    fontSize: 13, fontWeight: FontWeight.w800),
              ),
              Text(
                '\$' + widget.item.price.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.inter(fontSize: 13),
              )
            ]),
          )
        ],
      ),
    );
  }
}
