package org.project.to_do_java.exceptions;

import lombok.Getter;

@Getter
public enum ErrorMessages {
    TASK_NOT_FOUND("Task not found"),
    DUPLICATE_ITEM("Name of item cannot be duplicate"),
    ITEM_NOT_FOUND("Item not found");

    private final String message;

    ErrorMessages(String message) {
        this.message=message;
    }


}
