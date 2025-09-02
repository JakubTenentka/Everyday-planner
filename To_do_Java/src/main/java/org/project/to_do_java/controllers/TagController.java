package org.project.to_do_java.controllers;

import jakarta.validation.Valid;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.services.TagService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TagController {

    private final TagService tagService;

    public TagController(TagService tagService) {
        this.tagService = tagService;
    }

    @GetMapping("api/getTags")
    public ResponseEntity<List<Tag>> returnAllTags(){
        List<Tag> tags = tagService.returnAllTags();
        if(tags.isEmpty()){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
        }
        return ResponseEntity.status(HttpStatus.OK).body(tags);
    }

    @PostMapping("api/addTag")
    public ResponseEntity<Tag> addTag(@Valid @RequestBody Tag tag){
        return tagService.addTag(tag);
    }
}
