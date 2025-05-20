package com.lms.studentlms.util;

import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.model.User;

import java.util.Comparator;
import java.util.List;

/**
 * Utility class that provides various sorting algorithms for the application.
 * Implements insertion sort and other sorting methods.
 */
public class SortingUtils {

    /**
     * Sorts a list of registrations by timestamp using insertion sort.
     *
     * @param registrations The list to sort
     */
    public static void sortRegistrationsByTime(List<CourseRegistration> registrations) {
        if (registrations == null || registrations.size() <= 1) {
            return;
        }

        // Insertion sort algorithm
        for (int i = 1; i < registrations.size(); i++) {
            CourseRegistration key = registrations.get(i);
            long keyTime = key.getTimestamp();
            int j = i - 1;

            // Move elements that are greater than key to one position ahead
            while (j >= 0 && registrations.get(j).getTimestamp() > keyTime) {
                registrations.set(j + 1, registrations.get(j));
                j = j - 1;
            }
            registrations.set(j + 1, key);
        }
    }

    /**
     * Sorts a list of users by name using insertion sort.
     *
     * @param users The list to sort
     */
    public static void sortUsersByName(List<User> users) {
        if (users == null || users.size() <= 1) {
            return;
        }

        // Insertion sort algorithm
        for (int i = 1; i < users.size(); i++) {
            User key = users.get(i);
            String keyName = key.getFullName();
            int j = i - 1;

            // Move elements that are greater than key to one position ahead
            while (j >= 0 && users.get(j).getFullName().compareTo(keyName) > 0) {
                users.set(j + 1, users.get(j));
                j = j - 1;
            }
            users.set(j + 1, key);
        }
    }

    /**
     * Generic method to sort a list using insertion sort with a custom comparator.
     *
     * @param <T> The type of elements in the list
     * @param list The list to sort
     * @param comparator The comparator to use for sorting
     */
    public static <T> void insertionSort(List<T> list, Comparator<T> comparator) {
        if (list == null || list.size() <= 1) {
            return;
        }

        for (int i = 1; i < list.size(); i++) {
            T key = list.get(i);
            int j = i - 1;

            while (j >= 0 && comparator.compare(list.get(j), key) > 0) {
                list.set(j + 1, list.get(j));
                j = j - 1;
            }
            list.set(j + 1, key);
        }
    }

    /**
     * Sorts a list in ascending order using insertion sort.
     * Elements must implement Comparable.
     *
     * @param <T> The type of elements in the list
     * @param list The list to sort
     */
    public static <T extends Comparable<T>> void sort(List<T> list) {
        insertionSort(list, Comparator.naturalOrder());
    }

    /**
     * Sorts a list in descending order using insertion sort.
     * Elements must implement Comparable.
     *
     * @param <T> The type of elements in the list
     * @param list The list to sort
     */
    public static <T extends Comparable<T>> void sortDescending(List<T> list) {
        insertionSort(list, Comparator.reverseOrder());
    }
}
