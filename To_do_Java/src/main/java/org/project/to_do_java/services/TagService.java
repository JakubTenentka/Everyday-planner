package org.project.to_do_java.services;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.repositories.TagRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagService {
    private final TagRepository tagRepository;

    public TagService(TagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    public List<Tag> returnAllTags(){
       return tagRepository.findAll();
    }
    public ResponseEntity<Tag> addTag(Tag tag){
        Tag savedTag = tagRepository.save(tag);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedTag);
    }

}
