package com.lms.studentlms.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.lms.studentlms.util.FileUtils;

/**
 * Generic base DAO class for file-based data access operations
 * @param <T> The entity type this DAO handles
 */
public abstract class BaseDao<T> {

    private final String filePath;

    /**
     * Constructor that sets the file path for data storage
     * @param filePath Path to the file where entities are stored
     */
    public BaseDao(String filePath) {
        this.filePath = filePath;
    }

    /**
     * Finds all entities in the data store
     * @return List of all entities
     */
    public List<T> findAll() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(filePath);
            List<T> entities = new ArrayList<>();

            for (String line : lines) {
                T entity = mapEntityFromLine(line);
                if (entity != null) {
                    entities.add(entity);
                }
            }

            return entities;
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Saves an entity to the data store
     * @param entity Entity to save
     * @return true if successful, false otherwise
     */
    public boolean save(T entity) {
        try {
            List<String> lines = new ArrayList<>();
            lines.add(mapEntityToLine(entity));
            return FileUtils.writeLinesToFile(filePath, lines, true); // append mode
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
//try catch=risky version of throw
    /**
     * Saves multiple entities to the data store
     * @param entities List of entities to save
     * @return true if successful, false otherwise
     */
    public boolean saveAll(List<T> entities) {
        try {
            List<String> lines = new ArrayList<>();
            for (T entity : entities) {
                lines.add(mapEntityToLine(entity));
            }
            return FileUtils.writeLinesToFile(filePath, lines, true); // append mode
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Overwrites all data with the provided entities
     * @param entities List of entities to save
     * @return true if successful, false otherwise
     */
    public boolean saveAllOverwrite(List<T> entities) {
        try {
            List<String> lines = new ArrayList<>();
            for (T entity : entities) {
                lines.add(mapEntityToLine(entity));
            }
            return FileUtils.writeLinesToFile(filePath, lines, false); // overwrite mode
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Maps a line from the file to an entity object
     * @param line Line from the file
     * @return Entity object or null if mapping fails
     */
    protected abstract T mapEntityFromLine(String line);

    /**
     * Maps an entity object to a line for file storage
     * @param entity Entity to map
     * @return String representation of the entity
     */
    protected abstract String mapEntityToLine(T entity);
}
