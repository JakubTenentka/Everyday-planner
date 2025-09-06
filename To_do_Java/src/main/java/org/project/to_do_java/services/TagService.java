package org.project.to_do_java.services;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.repositories.TagRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
public class TagService {
    private final TagRepository tagRepository;

    public TagService(TagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    public List<Tag> returnAllTags(){
       return tagRepository.findAll();
    }

    public Tag addTag(Tag tag){
        return tagRepository.save(tag);
    }

    public List<Tag> returnTagsByIds(Set<Integer> tagIds) {
        return tagRepository.findAllById(tagIds);
    }

}
