import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void updateQuery(String query) {
    state = query;
  }
}

final searchProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});
