import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

interface Shape {
    double getArea();
}

class Rectangle implements Shape {
    private double length;
    private double width;

    public Rectangle(double length, double width) {
        this.length = length;
        this.width = width;
    }

    @Override
    public double getArea() {
        return length * width;
    }
}

class Circle implements Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
}

class Square extends Rectangle {
    public Square(double side) {
        super(side, side);
    }

    @Override
    public String toString() {
        return "Square[side=" + getWidth() + "]";
    }
}

class Cylinder extends Circle {
    private double height;

    public Cylinder(double radius, double height) {
        super(radius);
        this.height = height;
    }

    @Override
    public double getArea() {
        return 2 * Math.PI * getRadius() * height + 2 * super.getArea();
    }

    @Override
    public String toString() {
        return "Cylinder[radius=" + getRadius() + ", height=" + height + "]";
    }
}

class Person {
    private String name;
    private String address;

    public Person(String name, String address) {
        this.name = name;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }
}

class Student extends Person {
    private String[] courses = new String[30];
    private int[] grades = new int[30];
    private int numCourses = 0;

    public Student(String name, String address) {
        super(name, address);
    }

    public void addCourse(String course, int grade) {
        if (numCourses < 30) {
            courses[numCourses] = course;
            grades[numCourses] = grade;
            numCourses++;
        }
    }

    public void printCourses() {
        for (int i = 0; i < numCourses; i++) {
            System.out.println("Course: " + courses[i] + ", Grade: " + grades[i]);
        }
    }

    public double getAverageGrade() {
        int sum = 0;
        for (int i = 0; i < numCourses; i++) {
            sum += grades[i];
        }
        return (double) sum / numCourses;
    }
}

class Teacher extends Person {
    private String[] courses = new String[5];
    private int numCourses = 0;

    public Teacher(String name, String address) {
        super(name, address);
    }

    public void addCourse(String course) {
        if (numCourses < 5) {
            courses[numCourses] = course;
            numCourses++;
        }
    }

    public void removeCourse(String course) {
        for (int i = 0; i < numCourses; i++) {
            if (courses[i].equals(course)) {
                for (int j = i; j < numCourses - 1; j++) {
                    courses[j] = courses[j + 1];
                }
                numCourses--;
                break;
            }
        }
    }

    public void printCourses() {
        for (int i = 0; i < numCourses; i++) {
            System.out.println("Course: " + courses[i]);
        }
    }
}

public class Example {
    public static void main(String[] args) {
// overriding an inherited method
        Square square = new Square(5);
        System.out.println(square);

        // implementing an interface
        Shape[] shapes = new Shape[2];
        shapes[0] = new Rectangle(4, 5);
        shapes[1] = new Circle(3);
        for (Shape shape : shapes) {
            System.out.println(shape.getArea());
        }

        // initializing an object with data from a file
        try {
            Scanner scanner = new Scanner(new File("data.txt"));
            String name = scanner.nextLine();
            String address = scanner.nextLine();
            Student student = new Student(name, address);
            int numGrades = scanner.nextInt();
            for (int i = 0; i < numGrades; i++) {
                student.addCourse(scanner.nextLine(), scanner.nextInt());
            }
            scanner.close();
            student.printCourses();
            System.out.println("Average grade: " + student.getAverageGrade());
        } catch (FileNotFoundException e) {
            System.out.println("File not found: " + e.getMessage());
        }

        // demonstrating the use of a loop
        Teacher teacher = new Teacher("John Doe", "123 Main St.");
        teacher.addCourse("Math");
        teacher.addCourse("English");
        teacher.addCourse("Science");
        teacher.printCourses();
        teacher.removeCourse("English");
        teacher.printCourses();
    }
}