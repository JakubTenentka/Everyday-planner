package org.project.to_do_java.repositories;

import jakarta.transaction.Transactional;
import org.project.to_do_java.model.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Integer> {
    List<Task> findByIsDoneFalse();
    List<Task> findByIsDoneTrue();

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM task_tags WHERE task_id = :taskId", nativeQuery = true)
    void deleteRelations(@Param("taskId") Integer taskId);
}
