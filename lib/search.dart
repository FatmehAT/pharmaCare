import 'package:flutter/material.dart';
import 'medicines.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controllerID = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }

  void getMedicine() {
    try {
      int id = int.parse(_controllerID.text);
      search(update, id);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Wrong arguments')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search: '),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                    controller: _controllerID,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter medicine ID: '))),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: getMedicine,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                ),
                child: const Text('Find', style: TextStyle(fontSize: 18))),
            const SizedBox(height: 10),
            Center(
                child: SizedBox(
                    width: 200,
                    child: Flexible(
                        child: Text(_text,
                            style: const TextStyle(fontSize: 18))))),
          ],
        ),
      ),
    );
  }
}
