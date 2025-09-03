package org.project.to_do_java.converter;

import org.modelmapper.ModelMapper;
import org.project.to_do_java.dto.TagDto;
import org.project.to_do_java.model.Tag;
import org.springframework.stereotype.Component;

@Component
public class TagConverter {
    private final ModelMapper modelMapper;

    public TagConverter(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    public TagDto convertToDto(Tag tag){
        return modelMapper.map(tag, TagDto.class);
    }

    public Tag convertToEntity(TagDto tagDto){
        return modelMapper.map(tagDto, Tag.class);
    }
}
