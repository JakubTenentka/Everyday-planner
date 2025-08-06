package org.project.to_do_java.repositories;

import org.project.to_do_java.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Integer> {
    List<Task> findByIsDoneFalse();

    List<Task> findByIsDoneTrue();
}
