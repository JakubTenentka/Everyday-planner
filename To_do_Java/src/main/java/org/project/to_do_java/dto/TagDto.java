package org.project.to_do_java.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class TagDto {
    private Long id;

    @NotBlank(message = "Nazwa tagu nie może być pusta")
    private String tagName;
}
