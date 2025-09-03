package org.project.to_do_java;

import org.junit.jupiter.api.Test;
import org.project.to_do_java.model.Tag;
import org.project.to_do_java.repositories.TagRepository;
import org.project.to_do_java.services.TagService;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;
import static org.mockito.Mockito.times;

public class GetTagsByIdsTest {

    @Test
    void testReturnTagsByIds() {
        TagRepository tagRepository = mock(TagRepository.class);
        TagService tagService = new TagService(tagRepository);

        Set<Integer> ids = new HashSet<>(Arrays.asList(1, 2));
        List<Tag> expectedTags = Arrays.asList(new Tag(), new Tag());

        when(tagRepository.findAllById(ids)).thenReturn(expectedTags);

        List<Tag> result = tagService.returnTagsByIds(ids);

        assertEquals(expectedTags, result);
        verify(tagRepository, times(1)).findAllById(ids);
    }

}
