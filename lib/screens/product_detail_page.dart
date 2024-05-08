import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/cart_provider.dart';
import '../models/gadget.dart';

class ProductDetailPage extends ConsumerWidget {
  final Gadget gadget;

  const ProductDetailPage({super.key, required this.gadget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gadget.category),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(gadget.imageUrl[2], fit: BoxFit.cover),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(gadget.name, style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 10),
                  Text(gadget.price, style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 10),
                  Text(
                    gadget.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).add(gadget);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${gadget.name} added to cart!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
