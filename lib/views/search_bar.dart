import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

   const SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onSearch,
        decoration: const InputDecoration(
          labelText: 'Search name',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
