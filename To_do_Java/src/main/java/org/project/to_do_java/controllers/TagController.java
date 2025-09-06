package org.project.to_do_java.controllers;

import jakarta.validation.Valid;
import org.project.to_do_java.converter.TagConverter;
import org.project.to_do_java.dto.TagDto;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.services.TagService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class TagController {

    private final TagService tagService;
    private final TagConverter tagConverter;

    public TagController(TagService tagService, TagConverter tagConverter) {
        this.tagService = tagService;
        this.tagConverter = tagConverter;
    }

    @GetMapping("api/getTags")
    public ResponseEntity<List<TagDto>> returnAllTags(){
        List<Tag> tags = tagService.returnAllTags();
        if(tags.isEmpty()){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        return ResponseEntity.status(HttpStatus.OK).body(tags.stream().map(tagConverter::convertToDto).collect(Collectors.toList()));
    }

    @PostMapping("api/addTag")
    public ResponseEntity<TagDto> addTag(@Valid @RequestBody TagDto tagDto){
        Tag tag = tagConverter.convertToEntity(tagDto);
        Tag addedTag = tagService.addTag(tag);
        return ResponseEntity.status(HttpStatus.CREATED).body(tagConverter.convertToDto(addedTag));
    }
}
