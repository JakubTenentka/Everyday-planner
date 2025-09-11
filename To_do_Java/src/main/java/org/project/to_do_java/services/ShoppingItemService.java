package org.project.to_do_java.services;

import org.project.to_do_java.exceptions.ItemDuplicateException;
import org.project.to_do_java.exceptions.ItemNotFound;
import org.project.to_do_java.exceptions.TaskNotFoundException;
import org.project.to_do_java.model.ShoppingItem;
import org.project.to_do_java.repositories.ShoppingItemRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class ShoppingItemService {

    private final ShoppingItemRepository shoppingItemRepository;

    public ShoppingItemService(ShoppingItemRepository shoppingItemRepository) {
        this.shoppingItemRepository = shoppingItemRepository;
    }

    public List<ShoppingItem> returnItems() {
        return shoppingItemRepository.findAllByOrderByIsCheckedAsc();
    }

    public ShoppingItem addItem(ShoppingItem shoppingItem) {
        Optional<ShoppingItem> isfound = shoppingItemRepository.findById(shoppingItem.getName());
        if (isfound.isEmpty()){
            return shoppingItemRepository.save(shoppingItem);
        }
        throw new ItemDuplicateException();

    }

    public void checkItem(String itemId, boolean checked) throws Exception {
        Optional<ShoppingItem> foundItem = shoppingItemRepository.findById(itemId);
        if (foundItem.isPresent()){
            ShoppingItem itemToUpdate = foundItem.get();
            itemToUpdate.setChecked(checked);
            shoppingItemRepository.save(itemToUpdate);
        } else {
            throw new Exception("Nie znaleziono itemu");
        }

    }

    public void updateCount(String itemId, int count) throws ItemNotFound {
        Optional<ShoppingItem> foundItem = shoppingItemRepository.findById(itemId);
        if (foundItem.isPresent()){
            ShoppingItem itemToUpdate = foundItem.get();
            itemToUpdate.setCount(count);
            shoppingItemRepository.save(itemToUpdate);
        } else {
            throw new ItemNotFound("Nie znaleziono itemu");
        }
    }
}