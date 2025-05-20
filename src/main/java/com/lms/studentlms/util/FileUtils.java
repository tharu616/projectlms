package com.lms.studentlms.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility class for file operations used throughout the application.
 */
public class FileUtils {

    /**
     * Reads all lines from a file.
     *
     * @param filePath Path to the file
     * @return List of lines from the file
     * @throws IOException If an I/O error occurs
     */
    public static List<String> readLinesFromFile(String filePath) throws IOException {
        List<String> lines = new ArrayList<>();

        // Create file if it doesn't exist
        File file = new File(filePath);
        if (!file.exists()) {
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            file.createNewFile();
            return lines;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                lines.add(line);
            }
        }

        return lines;
    }

    /**
     * Writes lines to a file.
     *
     * @param filePath Path to the file
     * @param lines Lines to write
     * @param append If true, append to file; if false, overwrite
     * @return true if successful, false otherwise
     * @throws IOException If an I/O error occurs
     */
    public static boolean writeLinesToFile(String filePath, List<String> lines, boolean append) throws IOException {
        // Create file if it doesn't exist
        File file = new File(filePath);
        if (!file.exists()) {
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            file.createNewFile();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, append))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
            return true;
        }
    }

    /**
     * Writes lines to a file.
     *
     * @param filePath Path to the file
     * @param lines Lines to write
     * @return true if successful, false otherwise
     * @throws IOException If an I/O error occurs
     */
    public static boolean writeLinesToFile(String filePath, List<String> lines) throws IOException {
        return writeLinesToFile(filePath, lines, false);
    }

    /**
     * Ensures a directory exists, creating it if necessary.
     *
     * @param directoryPath Path to the directory
     * @return true if the directory exists or was created, false otherwise
     */
    public static boolean ensureDirectoryExists(String directoryPath) {
        Path path = Paths.get(directoryPath);
        if (Files.exists(path)) {
            return Files.isDirectory(path);
        }

        try {
            Files.createDirectories(path);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a file.
     *
     * @param filePath Path to the file
     * @return true if the file was deleted, false otherwise
     */
    public static boolean deleteFile(String filePath) {
        File file = new File(filePath);
        return file.exists() && file.delete();
    }

    /**
     * Checks if a file exists.
     *
     * @param filePath Path to the file
     * @return true if the file exists, false otherwise
     */
    public static boolean fileExists(String filePath) {
        return new File(filePath).exists();
    }
}
