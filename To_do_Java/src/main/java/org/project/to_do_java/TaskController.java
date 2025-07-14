package org.project.to_do_java;

import org.project.to_do_java.model.Task;
import org.project.to_do_java.services.TaskService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskController {

    private final TaskService taskService;


    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @PostMapping("/api/addTask")
    public ResponseEntity<Task> addTask (@RequestBody Task task){
        return taskService.addTask(task);
    }
}
