package org.project.to_do_java.services;

import org.project.to_do_java.model.Tag;
import org.project.to_do_java.model.Task;
import org.project.to_do_java.repositories.TaskRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Optional;


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

  public List<Task> returnTasks(){
      return taskRepository.findAll();
  }

  public List<Task> returnNotDoneTasks(){
        return taskRepository.findByIsDoneFalse();
  }

  public List<Task> returnDoneTasks(){
        return taskRepository.findByIsDoneTrue();
  }

  public ResponseEntity<Task> addTagsToTask(Integer id, List<Tag> tags){
        Optional<Task> taskToAddTags = taskRepository.findById(id);
        if(taskToAddTags.isPresent()){
            Task foundTask = taskToAddTags.get();
            List<Tag> TaskTags = foundTask.getTags();
            TaskTags.addAll(tags);
            foundTask.setTags(TaskTags);
            taskRepository.save(foundTask);
            return ResponseEntity.status(HttpStatus.CREATED).body(foundTask);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
  }

    public ResponseEntity<Void> updateIsDone(Integer taskid, boolean isDone) {
        Optional<Task> foundTask = taskRepository.findById(taskid);
        if (foundTask.isPresent()){
            Task taskToUpdate = foundTask.get();
            taskToUpdate.setIsDone(isDone);
            taskRepository.save(taskToUpdate);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
    public ResponseEntity<Void> deleteTask(Integer taskId){
        Optional<Task> taskToDelete = taskRepository.findById(taskId);
        if(taskToDelete.isPresent()){
            taskRepository.deleteRelations(taskId);
            taskRepository.deleteById(taskId);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        return null;
    }
}
