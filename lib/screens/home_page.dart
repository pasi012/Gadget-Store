import 'package:flutter/material.dart';
import 'package:gadget_store_app/screens/product_detail_page.dart';

import '../models/gadget.dart';
import '../services/gadget_service.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Gadget>> gadgets;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gadgets = GadgetService.fetchGadgets();
    searchController.addListener(_filterGadgets);
  }

  void _filterGadgets() {
    setState(() {
      gadgets = GadgetService.fetchGadgets().then((gadgetsList) =>
          gadgetsList.where((g) => g.name.toLowerCase().contains(searchController.text.toLowerCase())).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gadget Store', style: TextStyle(fontWeight: FontWeight.bold),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Gadget>>(
        future: gadgets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Gadget gadget = snapshot.data![index];
              return ListTile(
                leading: Image.network(gadget.imageUrl[2],
                    width: 50, height: 50, fit: BoxFit.cover),
                title: Text(gadget.name),
                subtitle: Text(gadget.price),
                onTap: () {
                  Navigator.of(context).push(_createRoute(gadget));
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute1());
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }


  Route _createRoute(Gadget gadget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ProductDetailPage(gadget: gadget),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.fastOutSlowIn));
        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }

  Route _createRoute1() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const CartPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.linear));
        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }

}
