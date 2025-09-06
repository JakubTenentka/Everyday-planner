package org.project.to_do_java.services;

import org.project.to_do_java.model.ShoppingItem;
import org.project.to_do_java.repositories.ShoppingItemRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingItemService {

    private final ShoppingItemRepository shoppingItemRepository;

    public ShoppingItemService(ShoppingItemRepository shoppingItemRepository) {
        this.shoppingItemRepository = shoppingItemRepository;
    }

    public List<ShoppingItem> returnItems() {
        return shoppingItemRepository.findAllByOrderByIsCheckedAsc();
    }
}