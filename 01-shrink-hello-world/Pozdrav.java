package hr.javacro.proguard;

import java.util.*;

class Pozdrav {
    static class Calc {
        public static int getYear(int y1000, int y100, int y10, int y1) {
            if (y1000 > 0) {
                return getYear(0, 10 * y1000 + y100, y10, y1);
            } else if (y100 > 0) {
                return getYear(0, 0, 10 * y100 + y10, y1);
            } else if (y10 > 0) {
                return getYear(0, 0, 0, 10 * y10 + y1);
            } else {
                return y1;
            }
        }
    }

    static class Poruka implements Iterable<String> {
        private final int year = Calc.getYear(2, 0, 1, 5);

        private final Iterable<String> lines =
            Arrays.asList("Pozdrav", "sa", "JavaCroa", year + "!");

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
