import 'package:flutter/material.dart';

class ModernSearchBar extends StatelessWidget {
  final String hintText;

  const ModernSearchBar({super.key, this.hintText = 'Search...'});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hintText,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
