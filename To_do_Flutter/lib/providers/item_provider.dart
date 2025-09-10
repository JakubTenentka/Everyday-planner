import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/model/item_class.dart';
import 'package:to_do_flutter/services/item_service.dart';

final itemServiceProvider = Provider<ItemService>((ref) {
  return ItemService();
});

final itemProvider =
    StateNotifierProvider<ItemNotifier, AsyncValue<List<Item>>>((ref) {
  final itemService = ref.watch(itemServiceProvider);
  return ItemNotifier(itemService);
});

class ItemNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  final ItemService _itemService;

  ItemNotifier(this._itemService) : super(const AsyncValue.loading()) {
    _fetchInitialItems();
  }

  Future<void> _fetchInitialItems() async {
    try {
      state = const AsyncValue.loading();
      final items = await _itemService.fetchAllItems();
      state = AsyncValue.data(items);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> addItem(String name) async {
    final currentStateValue = state.valueOrNull ?? [];
    Item newItemData = Item(name: name);
    try {
      final Item addedItem = await _itemService.addItem(newItemData);
      final updatedList = [...currentStateValue, addedItem];
      state = AsyncValue.data(updatedList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> toggleItemChecked(String itemId, bool isChecked) async {
    final currentItems = state.valueOrNull ?? [];
    await _itemService.markCompletion(itemId, isChecked);
    final updatedItems = currentItems.map((item) {
      if (item.name == itemId) {
        return item.copyWith(isChecked: isChecked);
      }
      return item;
    }).toList();

    state = AsyncData(updatedItems);
  }

  Future<void> refreshItems() async {
    await _fetchInitialItems();
  }
}
