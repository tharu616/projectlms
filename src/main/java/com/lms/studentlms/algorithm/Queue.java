package com.lms.studentlms.algorithm;

import java.util.LinkedList;
import java.util.NoSuchElementException;

/**
 * A generic implementation of the Queue data structure using the FIFO (First-In-First-Out) principle.
 * This class provides basic queue operations like enqueue, dequeue, peek, and checking if empty.
 *
 * @param <T> The type of elements stored in the queue
 */
public class Queue<T> {
    private LinkedList<T> elements;

    /**
     * Constructs an empty queue.
     */
    public Queue() {
        this.elements = new LinkedList<>();
    }

    /**
     * Adds an element to the end of the queue.
     *
     * @param item The element to add
     */
    public void enqueue(T item) {
        elements.addLast(item);
    }

    /**
     * Removes and returns the element at the front of the queue.
     *
     * @return The element at the front of the queue
     * @throws NoSuchElementException if the queue is empty
     */
    public T dequeue() {
        if (isEmpty()) {
            throw new NoSuchElementException("Cannot dequeue from an empty queue");
        }
        return elements.removeFirst();
    }

    /**
     * Returns the element at the front of the queue without removing it.
     *
     * @return The element at the front of the queue
     * @throws NoSuchElementException if the queue is empty
     */
    public T peek() {
        if (isEmpty()) {
            throw new NoSuchElementException("Cannot peek an empty queue");
        }
        return elements.getFirst();
    }

    /**
     * Checks if the queue is empty.
     *
     * @return true if the queue is empty, false otherwise
     */
    public boolean isEmpty() {
        return elements.isEmpty();
    }

    /**
     * Returns the number of elements in the queue.
     *
     * @return The number of elements in the queue
     */
    public int size() {
        return elements.size();
    }

    /**
     * Removes all elements from the queue.
     */
    public void clear() {
        elements.clear();
    }

    /**
     * Returns a copy of all elements in the queue as a LinkedList.
     *
     * @return A LinkedList containing all elements in the queue
     */
    public LinkedList<T> getAllElements() {
        return new LinkedList<>(elements);
    }

    /**
     * Returns a string representation of the queue.
     *
     * @return A string representation of the queue
     */
    @Override
    public String toString() {
        return elements.toString();
    }
}
