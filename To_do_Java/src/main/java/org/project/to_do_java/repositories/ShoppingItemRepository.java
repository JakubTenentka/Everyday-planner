package org.project.to_do_java.repositories;

import org.project.to_do_java.model.ShoppingItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShoppingItemRepository extends JpaRepository<ShoppingItem, String> {
    List<ShoppingItem> findAllByOrderByIsCheckedAsc();
}
