package org.project.to_do_java.services;

import org.apache.coyote.Response;
import org.project.to_do_java.model.Task;
import org.project.to_do_java.repositories.TaskRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Service
public class TaskService {

    private final TaskRepository taskRepository;

    public TaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

  public ResponseEntity<Task> addTask(Task task){
       Task savedTask = taskRepository.save(task);
       return ResponseEntity.status(HttpStatus.CREATED).body(savedTask);
  }
}
