import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NewsController c = Get.find<NewsController>();
    _controller.text = c.query.value;

    void performSearch(String value) {
      if (value.trim().isEmpty) return;

      // Trigger search
      c.onSearchChanged(value.trim());

      // Show loading dialog
      Get.dialog(
        Obx(() {
          if (!c.isLoading.value) {
            if (Get.isDialogOpen ?? false) Get.back();
            Get.back(); // go back to HomePage
          }
          return const Center(child: CircularProgressIndicator());
        }),
        barrierDismissible: false,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search news',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _controller.clear(),
                  ),
                ),
                onSubmitted: performSearch,
              ),
              const SizedBox(height: 12),
              Obx(() {
                final history = c.searchHistory;
                if (history.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent searches',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: history.map((q) {
                        return ActionChip(
                          label: Text(q),
                          onPressed: () => performSearch(q),
                        );
                      }).toList(),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
