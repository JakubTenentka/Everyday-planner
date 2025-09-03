package org.project.to_do_java.dto;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
public class TaskDto {

private Integer id;

@NotBlank(message = "Tytuł jest wymagany i nie może być pusty")
private String title;

@FutureOrPresent(message = "Nie można wpisać przeszłej daty")
private LocalDate endingDate;
private List<TagDto> tags = new ArrayList<>();
Boolean isDone;
}
