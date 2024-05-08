import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/gadget.dart';

class CartState {
  final List<Gadget> items;

  CartState({this.items = const []});

  int parsePrice(String priceString) {
    String numericPart = priceString.replaceFirst('\$', '');  // Remove the dollar sign
    return int.parse(numericPart);  // Convert the remaining part to an integer
  }

  double get totalPrice => items.fold(0, (total, current) => total + parsePrice(current.price));

  CartState copyWith({List<Gadget>? items}) {
    return CartState(
      items: items ?? this.items,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState());

  void add(Gadget gadget) {
    state = state.copyWith(items: List.from(state.items)..add(gadget));
  }

  void remove(Gadget gadget) {
    state = state.copyWith(items: List.from(state.items)..remove(gadget));
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier());
