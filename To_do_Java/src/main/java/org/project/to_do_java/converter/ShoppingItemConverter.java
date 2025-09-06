package org.project.to_do_java.converter;

import org.modelmapper.ModelMapper;
import org.project.to_do_java.dto.ShoppingItemDto;
import org.project.to_do_java.model.ShoppingItem;
import org.springframework.stereotype.Component;

@Component
public class ShoppingItemConverter {

    private final ModelMapper modelMapper;

    public ShoppingItemConverter(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public ShoppingItemDto convertToDto(ShoppingItem shoppingItem){
        return modelMapper.map(shoppingItem, ShoppingItemDto.class);
    }

    public ShoppingItem converToEntity(ShoppingItemDto shoppingItemDto){
        return modelMapper.map(shoppingItemDto, ShoppingItem.class);
    }
}
