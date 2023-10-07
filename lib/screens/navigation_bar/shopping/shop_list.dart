import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/routes/routes.dart';
import 'package:gardenguru/utils/plants_support.dart';
import 'package:google_fonts/google_fonts.dart';

class Shop {
  String address, name, image, description;
  Shop(
      {required this.name,
      required this.address,
      required this.image,
      required this.description,
      required this.items});
  List<Item> items;
}

class Item {
  String name, image, description, imageShop;
  int price;
  String nameShop;
  Item(
      {required this.name,
      required this.image,
      required this.description,
      required this.nameShop,
      required this.imageShop,
      required this.price});
}

Item sunflower = Item(
    name: 'Sunflower seeds',
    image: 'assets/other_material/sunflower_seed.png',
    price: 10,
    imageShop: 'assets/other_material/1.jpg',
    nameShop: 'Himitsu no Kichi',
    description:
        'Sunflower seeds, derived from the Helianthus annuus plant, are nutrient-packed marvels. Rich in healthy fats, proteins, fibers, and essential vitamins and minerals, they offer numerous health benefits. These seeds, consumed raw, roasted, or as oil, support heart health, aid in weight management, and boost energy levels. Cultivated globally, sunflowers are not only a source of nutritious seeds but also iconic for their large, yellow flower heads, making them essential in both agriculture and culinary applications.');

Item npk_fertilizer = Item(
    name: 'NPK Fertilizer',
    image: 'assets/other_material/npk_fertilizer.png',
    nameShop: 'Fertile Harvest',
    price: 10,
    imageShop: 'assets/other_material/2.jpg',
    description:
        'NPK fertilizer is a vital nutrient blend containing nitrogen (N), phosphorus (P), and potassium (K). Each element serves a specific role in plant growth. Nitrogen promotes leaf and stem development, essential for photosynthesis. Phosphorus supports strong root systems, flowering, and fruiting, while potassium enhances overall plant health, aiding in disease resistance and water regulation. The NPK ratio on fertilizer labels indicates the proportion of these nutrients, crucial for tailored plant nutrition and optimal crop yield.');

List<Item> shop1 = [sunflower];
List<Item> shop2 = [npk_fertilizer];

final Shop himitsu_no_kichi = Shop(
    name: 'Himitsu no Kichi',
    address: '227 Nguyen Van Cu, phuong 4, quan 5',
    image: 'assets/other_material/1.jpg',
    description:
        '"Himitsu no Kichi," or "Secret Haven," is a captivating shop where mystery meets curiosity. Step into a world of enchantment, filled with unique treasures and surprises from around the world. This hidden gem invites you to explore a curated collection of delightful finds, making every visit a magical experience.',
    items: shop1);

Shop fertile_harvest = Shop(
    name: 'Fertile Harvest',
    address: '227 Nguyen Van Cu, phuong 4, quan 10',
    image: 'assets/other_material/2.jpg',
    description:
        '"Grow Green" is your go-to destination for premium fertilizers. We offer a curated selection of top-quality products to enhance your gardening experience. Our expertly crafted fertilizers ensure healthy plant growth, making your garden bloom with vitality. Explore our store for tailored solutions that transform your green space into a thriving paradise.',
    items: shop2);

class ShopList extends StatefulWidget {
  final List<Shop> shops = [himitsu_no_kichi, fertile_harvest];

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.pushRoute(ShopRoute(shop: widget.shops[index]));
            },
            child: ShopItem(item: widget.shops[index]),
          );
        },
      ),
    );
  }
}

class ShopItem extends StatefulWidget {
  Shop item;

  ShopItem({required this.item});

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
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
                widget.item.address,
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
