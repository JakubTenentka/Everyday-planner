package org.project.to_do_java.controllers;

import org.project.to_do_java.converter.ShoppingItemConverter;
import org.project.to_do_java.dto.ShoppingItemDto;
import org.project.to_do_java.model.ShoppingItem;
import org.project.to_do_java.services.ShoppingItemService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/shopping")
public class ShoppingItemController {

    private final ShoppingItemService shoppingItemService;
    private final ShoppingItemConverter shoppingItemConverter;

    public ShoppingItemController(ShoppingItemService shoppingItemService, ShoppingItemConverter shoppingItemConverter) {
        this.shoppingItemService = shoppingItemService;
        this.shoppingItemConverter = shoppingItemConverter;
    }

    @GetMapping("/getItems")
    public ResponseEntity<List<ShoppingItemDto>> returnAllShoppingItems (){
        List<ShoppingItem> items = shoppingItemService.returnItems();
        if(items.isEmpty()){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        return ResponseEntity.status(HttpStatus.OK).body(items.stream().map(shoppingItemConverter::convertToDto).collect(Collectors.toList()));
    }

}
