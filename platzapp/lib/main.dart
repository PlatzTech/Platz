import 'package:flutter/material.dart';
import 'map_page.dart';

void main() {
  runApp(MaterialApp(title: 'Platz', home: HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open MapPage'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            );
          },
        ),
      ),
    );
  }
}
