import 'package:flutter/material.dart';
import 'medicines.dart';

class Cart {
  final Medicine medicine;
  final int quantity;

  Cart(this.medicine, this.quantity);
}

class ShowCart extends StatefulWidget {
  final List<Cart>? cartItems;

  const ShowCart({super.key, this.cartItems});

  @override
  State<ShowCart> createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.purple,
      ),
      body: widget.cartItems?.isEmpty ?? true
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: widget.cartItems?.length ?? 0,
              itemBuilder: (context, index) {
                final cartItem = widget.cartItems![index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItem.medicine.name),
                        Text('Quantity: ${cartItem.quantity}'),
                        Text(
                          'Price: \$${(cartItem.medicine.price * cartItem.quantity).toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
