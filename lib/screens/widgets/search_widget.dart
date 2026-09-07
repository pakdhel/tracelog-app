import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final ValueChanged<String> onValueChanged;
  const SearchWidget({super.key, required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        onValueChanged(value);
      },
      decoration: InputDecoration(
        hintText: "Search address",
        hintStyle: TextStyle(fontWeight: FontWeight.normal),
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }
}
