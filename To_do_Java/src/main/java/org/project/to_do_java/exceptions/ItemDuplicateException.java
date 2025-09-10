package org.project.to_do_java.exceptions;

public class ItemDuplicateException extends RuntimeException {
    public ItemDuplicateException() {
        super(ErrorMessages.DUPLICATE_ITEM.getMessage());
    }
}
