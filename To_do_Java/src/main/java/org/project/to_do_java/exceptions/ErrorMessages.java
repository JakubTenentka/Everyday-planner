package org.project.to_do_java.exceptions;

import lombok.Getter;

@Getter
public enum ErrorMessages {
    TASK_NOT_FOUND("Task not found");

    private final String message;

    ErrorMessages(String message) {
        this.message=message;
    }


}
