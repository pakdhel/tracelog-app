import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search address or coordinates…",
        hintStyle: TextStyle(fontWeight: FontWeight.normal),
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }
}
