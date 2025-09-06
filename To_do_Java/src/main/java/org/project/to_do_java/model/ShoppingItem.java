package org.project.to_do_java.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
public class ShoppingItem {

    @Id
    private String name;

    private boolean isChecked;

    private int count;
}
