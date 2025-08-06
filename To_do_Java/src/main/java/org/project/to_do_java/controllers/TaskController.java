package org.project.to_do_java.controllers;

import org.project.to_do_java.model.Tag;
import org.project.to_do_java.model.Task;
import org.project.to_do_java.services.TagService;
import org.project.to_do_java.services.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@RestController
public class TaskController {

    private final TaskService taskService;
    private final TagService tagService;


    public TaskController(TaskService taskService, TagService tagService) {
        this.taskService = taskService;
        this.tagService = tagService;
    }

    @PostMapping("/api/addTask")
    public ResponseEntity<Task> addTask (@RequestBody Task task, @RequestParam("tagIds") Set<Integer> tagIds) {
        if (tagIds != null && !tagIds.isEmpty()) {
            List<Tag> tags = tagService.returnTagsByIds(tagIds);
            task.setTags(tags);
        }
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

    @PostMapping("/api/addTagsToTask/{taskId}")
    public ResponseEntity<Task> addTagsToTask(@PathVariable Integer taskId, @RequestBody List<Tag> tags){
        return taskService.addTagsToTask(taskId,tags);
    }

    }


