import 'package:intl/intl.dart';

String formatDate(String? iso) {
  if (iso == null) return '';
  try {
    final dt = DateTime.parse(iso).toLocal();
    return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
  } catch (e) {
    return iso;
  }
}
