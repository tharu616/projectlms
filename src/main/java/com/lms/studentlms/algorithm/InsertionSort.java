package com.lms.studentlms.algorithm;

import java.util.Comparator;
import java.util.List;

/**
 * Implementation of the Insertion Sort algorithm.
 * Insertion sort is a simple sorting algorithm that builds the final sorted array one item at a time.
 * It is efficient for small data sets and is often used as part of more sophisticated algorithms.
 */
public class InsertionSort {

    /**
     * Sorts a list using the insertion sort algorithm.
     *
     * @param <T> The type of elements in the list (must implement Comparable)
     * @param list The list to be sorted
     */
    public static <T extends Comparable<T>> void sort(List<T> list) {
        if (list == null || list.size() <= 1) {
            return; // Already sorted
        }

        for (int i = 1; i < list.size(); i++) {
            T key = list.get(i);
            int j = i - 1;

            // Move elements that are greater than key to one position ahead
            while (j >= 0 && list.get(j).compareTo(key) > 0) {
                list.set(j + 1, list.get(j));
                j = j - 1;
            }
            list.set(j + 1, key);
        }
    }

    /**
     * Sorts a list using the insertion sort algorithm with a custom comparator.
     *
     * @param <T> The type of elements in the list
     * @param list The list to be sorted
     * @param comparator The comparator to determine the order
     */
    public static <T> void sort(List<T> list, Comparator<? super T> comparator) {
        if (list == null || list.size() <= 1 || comparator == null) {
            return; // Already sorted or invalid input
        }

        for (int i = 1; i < list.size(); i++) {
            T key = list.get(i);
            int j = i - 1;

            // Move elements that are greater than key to one position ahead
            while (j >= 0 && comparator.compare(list.get(j), key) > 0) {
                list.set(j + 1, list.get(j));
                j = j - 1;
            }
            list.set(j + 1, key);
        }
    }

    /**
     * Sorts a list in descending order using the insertion sort algorithm.
     *
     * @param <T> The type of elements in the list (must implement Comparable)
     * @param list The list to be sorted
     */
    public static <T extends Comparable<T>> void sortDescending(List<T> list) {
        if (list == null || list.size() <= 1) {
            return; // Already sorted
        }

        for (int i = 1; i < list.size(); i++) {
            T key = list.get(i);
            int j = i - 1;

            // Move elements that are less than key to one position ahead
            while (j >= 0 && list.get(j).compareTo(key) < 0) {
                list.set(j + 1, list.get(j));
                j = j - 1;
            }
            list.set(j + 1, key);
        }
    }

    /**
     * Private constructor to prevent instantiation.
     * This class only provides static methods.
     */
    private InsertionSort() {
        // Utility class, no instantiation
    }
}
