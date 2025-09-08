import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/tag_class.dart';
import '../services/tag_service.dart';

final tagServiceProvider = Provider<TagService>((ref) {
  return TagService();
});

final tagsProvider = FutureProvider<List<Tag>>((ref) async {
  final tagService = ref.watch(tagServiceProvider);
  return tagService.fetchAllTags();
});
