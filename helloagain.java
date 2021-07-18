public class Main {
    public main() {
        Vector<int> A = new Vector<>([1, 2, 3]);
        Vector<int> B = new Vector<>([10, 20, 30]);

        System.out.println(A.getComponents());
        System.out.println(B.getComponents());

        System.out.println(Vector<int>.squaredDistance(A, B));
    }
}

public class Vector<T> implements Comparable<Vector<T>> {
    private T[] components;
    private int numComponents;

    public Vector(T[] components) {
        this.components = components;
        numComponents = components.length;
    }

    public T[] getComponents() {
        return this.components;
    }

    public int getNumComponents() {
        return this.numComponents;
    }

    public T squaredLength() {
        T squaredLength = 0;

        for (T a : this.components) {
            squaredLength += a * a;
        }

        return squaredLength;
    }

    public static T squaredDistance(Vector A, Vector B) {
        T squaredDistance = 0;
        int i = 0;

        while (i < A.getNumComponents() || i < B.getNumComponents()) {
            T a = 0;
            T b = 0;

            if (i < A.getNumComponents()) {
                a = A.getComponents()[i];
            }
            if (i < B.getNumComponents()) {
                b = B.getComponents()[i];
            }

            squaredDistance += (b - a) * (b - a);
        }

        return squaredDistance;
    }

    public static int dotProduct(Vector A, Vector B) {
        T dotProduct = 0;
        int i = 0;

        while (i < A.getNumComponents() || i < B.getNumComponents()) {
            T a = 0;
            T b = 0;

            if (i < A.getNumComponents()) {
                a = A.getComponents()[i];
            }
            if (i < B.getNumComponents()) {
                b = B.getComponents()[i];
            }

            dotProduct += a * b;
        }

        return dotProduct;
    }

    public T compareTo(Vector rhs) {
        return squaredDistance(this, rhs);
    }
}