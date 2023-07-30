import 'package:flutter/material.dart';
import 'package:fsearch/fsearch.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.width,
    required this.onSearchCallback,
    required this.hintText,
  });
  final double width;
  final Function(String) onSearchCallback;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return FSearch(
      height: 45,
      width: width,
      padding: const EdgeInsets.all(8),
      corner: FSearchCorner.all(10),
      backgroundColor: Colors.grey.withOpacity(0.2),
      hints: [hintText, '', ''],
      hintStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      onSearch: onSearchCallback,
      prefixes: const [
        SizedBox(width: 6.0),
        Icon(
          Icons.search,
          size: 18,
        ),
        SizedBox(width: 3.0)
      ],
    );
  }
}
