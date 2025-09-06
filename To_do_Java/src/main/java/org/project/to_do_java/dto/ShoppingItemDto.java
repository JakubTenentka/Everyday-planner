package org.project.to_do_java.dto;

import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.Data;

@Data
public class ShoppingItemDto {

    @NotBlank(message = "Nazwa produktu nie może być pusta")
    private String name;

    private boolean isChecked;

    @PositiveOrZero(message = "Liczba produktów nie może być ujemna")
    private int count;
}
