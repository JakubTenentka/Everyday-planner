import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
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

  final Map<String, Timer> _debounceTimers = {};

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

  void changeItemCount(String itemId, bool isAdded) {
    state = state.whenData((items) {
      return items.map((item) {
        if (item.name == itemId) {
          if (isAdded == true) {
            return item.copyWith(count: item.count + 1);
          } else if (isAdded == false) {
            return item.copyWith(count: item.count - 1);
          }
        }
        return item;
      }).toList();
    });

    _debounceTimers[itemId]?.cancel();
    _debounceTimers[itemId] = Timer(const Duration(seconds: 2), () {
      final currentItemsFromState = state.valueOrNull;
      if (currentItemsFromState == null) {
        return;
      }

      final currentItem = currentItemsFromState.firstWhere(
          (i) => i.name == itemId,
          orElse: () => Item(name: "error_not_found", count: -1));

      if (currentItem.name != "error_not_found") {
        _itemService
            .updateCount(currentItem.count, currentItem.name)
            .then((_) {})
            .catchError((error, stackTrace) {
          throw Error();
        });
      } else {}
    });
  }

  Future<void> clearAllItems() async {
    try {
      Response response = await _itemService.deleteAllItems();
      if (response.statusCode == 204) {
        state = const AsyncValue.data([]);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  @override
  void dispose() {
    _debounceTimers.forEach((_, timer) => timer.cancel());
    _debounceTimers.clear();
    super.dispose();
  }

  Future<void> refreshItems() async {
    await _fetchInitialItems();
  }
}
