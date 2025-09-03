package org.project.to_do_java.controllers;

import jakarta.validation.Valid;
import org.project.to_do_java.converter.TagConverter;
import org.project.to_do_java.converter.TaskConverter;
import org.project.to_do_java.dto.TagDto;
import org.project.to_do_java.dto.TaskDto;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.model.Task;
import org.project.to_do_java.services.TagService;
import org.project.to_do_java.services.TaskService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
public class TaskController {

    private final TaskService taskService;
    private final TagService tagService;
    private final TaskConverter taskConverter;
    private final TagConverter tagConverter;


    public TaskController(TaskService taskService, TagService tagService, TaskConverter taskConverter, TagConverter tagConverter) {
        this.taskService = taskService;
        this.tagService = tagService;
        this.taskConverter = taskConverter;
        this.tagConverter = tagConverter;
    }

    @PostMapping("/api/addTask")
    public ResponseEntity<Task> addTask (@Valid @RequestBody TaskDto taskDto, @RequestParam(value = "tagIds", required = false) Set<Integer> tagIds) {
        Task task = taskConverter.convertToEntity(taskDto);
        if (tagIds != null && !tagIds.isEmpty()) {
            List<Tag> tags = tagService.returnTagsByIds(tagIds);
            task.setTags(tags);
        }
        return taskService.addTask(task);
    }

    @GetMapping("/api/getTasks")
    public ResponseEntity<List<TaskDto>> returnAllTasks(@RequestParam(value = "isDone", required = false) Boolean isDone){
        List<Task> tasks = new ArrayList<>();
        if (isDone == null){
             tasks = taskService.returnTasks();
        } else if (isDone == true){
             tasks = taskService.returnDoneTasks();
        } else if (isDone == false){
             tasks = taskService.returnNotDoneTasks();
        }

        if (tasks.isEmpty()){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        return ResponseEntity.status(HttpStatus.OK).body(tasks.stream().map(taskConverter::convertToDto).collect(Collectors.toList()));
    }

    @PostMapping("/api/addTagsToTask/{taskId}")
    public ResponseEntity<Task> addTagsToTask(@PathVariable Integer taskId, @RequestBody List<TagDto> tagsDto){
        List<Tag> tags = tagsDto.stream().map(tagConverter::convertToEntity).collect(Collectors.toList());
        return taskService.addTagsToTask(taskId,tags);
    }

    @PatchMapping("/api/updateTaskStatus/{taskid}")
    public ResponseEntity<Void> updateTaskStatus(@PathVariable Integer taskid, @RequestParam("status") boolean status){
        return taskService.updateIsDone(taskid, status);
    }

    @DeleteMapping("/api/deleteTask/{taskId}")
    public ResponseEntity<Void> deleteTask(@PathVariable Integer taskId){
        return taskService.deleteTask(taskId);
    }

    }


