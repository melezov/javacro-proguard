package com.javacro.proguard;

import java.util.*;

class Pozdrav {
    static class Poruka implements Iterable<String> {
        private final List<String> lines = Arrays.asList("Pozdrav", "sa", "JavaCroa!");

        public Iterator<String> iterator() {
            return lines.iterator();
        }
    }

    public static void main(final String[] args) {
        for (final String line : new Poruka()) {
            System.out.println(line);
        }
    }
}
