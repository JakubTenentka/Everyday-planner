package org.project.to_do_java.converter;

import org.modelmapper.ModelMapper;
import org.project.to_do_java.dto.TaskDto;
import org.project.to_do_java.model.Task;
import org.springframework.stereotype.Component;

@Component
public class TaskConverter {


    private final ModelMapper modelMapper;

    public TaskConverter(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public TaskDto convertToDto(Task task){
        return modelMapper.map(task, TaskDto.class);
    }

    public Task convertToEntity(TaskDto taskDto) {
        return modelMapper.map(taskDto, Task.class);
    }


}
