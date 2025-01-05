import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String _baseURL = 'pharmacares.infinityfreeapp.com/index.php';

class Medicine {
  final int id;
  final String name;
  final int quantity;
  final double price;

  Medicine(this.id, this.name, this.quantity, this.price);

  @override
  String toString() {
    return 'ID: $id Name: $name\nQuantity: $quantity \nPrice: \$$price';
  }
}

List<Medicine> _medicines = [];

void updateMedicines(Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'index.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _medicines.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Medicine m = Medicine(int.parse(row['id']), row['name'],
            int.parse(row['quantity']), double.parse(row['price']));
        _medicines.add(m);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void search(Function(String text) update, int id) async {
  try {
    final url = Uri.http(_baseURL, 'search.php', {'id': '$id'});
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _medicines.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Medicine m = Medicine(int.parse(row['id']), row['name'],
          int.parse(row['quantity']), double.parse(row['price']));
      _medicines.add(m);
      update(m.toString());
    }
  } catch (e) {
    update("Unable to load data");
  }
}

@override
Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return ListView.builder(
      itemCount: _medicines.length,
      itemBuilder: (context, index) => Column(children: [
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.all(5),
                width: width * 0.9,
                child: Row(children: [
                  SizedBox(width: width * 0.15),
                  Flexible(
                      child: Text(_medicines[index].toString(),
                          style: TextStyle(fontSize: width * 0.045))),
                ]))
          ]));
}

class ShowMedicines extends StatelessWidget {
  final Function(Medicine) onAddToCart;

  const ShowMedicines({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: _medicines.length,
      itemBuilder: (context, index) => Column(children: [
        const SizedBox(height: 10),
        Container(
          color: index % 2 == 0 ? Colors.amber : Colors.cyan,
          padding: const EdgeInsets.all(5),
          width: width * 0.9,
          child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(
              child: Text(
                _medicines[index].toString(),
                style: TextStyle(fontSize: width * 0.045),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                onAddToCart(_medicines[index]);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
