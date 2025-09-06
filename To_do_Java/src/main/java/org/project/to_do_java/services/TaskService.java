package org.project.to_do_java.services;

import org.project.to_do_java.exceptions.TaskNotFoundException;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.model.Task;
import org.project.to_do_java.repositories.TaskRepository;
import org.springframework.stereotype.Service;


import java.util.List;
import java.util.Optional;


@Service
public class TaskService {

    private final TaskRepository taskRepository;

    public TaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

  public Task addTask(Task task){
      return taskRepository.save(task);
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

  public Task addTagsToTask(Integer id, List<Tag> tags){
        Optional<Task> taskToAddTags = taskRepository.findById(id);
        if(taskToAddTags.isPresent()){
            Task foundTask = taskToAddTags.get();
            List<Tag> TaskTags = foundTask.getTags();
            TaskTags.addAll(tags);
            foundTask.setTags(TaskTags);
            return taskRepository.save(foundTask);
        } else {
            throw new TaskNotFoundException();
        }
  }

    public Task updateIsDone(Integer taskid, boolean isDone) {
        Optional<Task> foundTask = taskRepository.findById(taskid);
        if (foundTask.isPresent()){
            Task taskToUpdate = foundTask.get();
            taskToUpdate.setIsDone(isDone);
            return taskRepository.save(taskToUpdate);
        } else {
            throw new TaskNotFoundException();
        }
    }
    public void deleteTask(Integer taskId){
        Optional<Task> taskToDelete = taskRepository.findById(taskId);
        if(taskToDelete.isPresent()){
            taskRepository.deleteRelations(taskId);
            taskRepository.deleteById(taskId);
        }
        throw new TaskNotFoundException();
    }
}
