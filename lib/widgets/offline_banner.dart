import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  final bool online;
  const OfflineBanner({required this.online, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (online) return SizedBox.shrink();
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: const [
          Icon(Icons.signal_wifi_off, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Offline - showing cached content',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
