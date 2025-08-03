package org.project.to_do_java.controllers;

import org.project.to_do_java.model.Task;
import org.project.to_do_java.services.TaskService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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

    @GetMapping("api/getTasks")
    public ResponseEntity<List<Task>> returnAllTasks(){
        List<Task> tasks = taskService.returnTasks();
        if (tasks.isEmpty()){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(tasks);
    }

}
