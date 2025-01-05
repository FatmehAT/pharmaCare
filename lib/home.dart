import 'package:flutter/material.dart';
import 'search.dart';
import 'medicines.dart';
import 'cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _load = false;
  final List<Cart> _cart = [];

  void _addToCart(Medicine medicine) {
    setState(() {
      _cart.add(Cart(medicine, 1));
    });
  }

  void _viewCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowCart(cartItems: _cart),
      ),
    );
  }

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to load data')));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateMedicines(update);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: _viewCart,
            ),
            IconButton(
                onPressed: !_load
                    ? null
                    : () {
                        setState(() {
                          _load = false;
                          updateMedicines(update);
                        });
                      },
                icon: const Icon(Icons.refresh)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Search()));
                },
                icon: const Icon(Icons.search))
          ],
          title: const Text('Available Medicines'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: _load
            ? ShowMedicines(onAddToCart: _addToCart)
            : const Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator())));
  }
}
