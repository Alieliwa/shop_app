import 'package:flutter/material.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Search')),
      ),
      body: Center(
        child: Text('Search Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
      ),
    );

  }
}
