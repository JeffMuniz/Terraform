/*  Polymorphism, in the context of object-oriented programming (OOP), refers to the ability of different classes to be treated
as instances of the same class through a common interface. This allows objects of different classes to be treated uniformly.
    There are two main types of polymorphism: Compile-time Polymorphism (Method Overloading): This occurs when there are multiple
methods with the same name in a class, but they differ in the number or types of their parameters. During compile-time, 
the correct method to be executed is determined based on the number and types of arguments passed. Example:Calculator 

Run-time Polymorphism (Method Overriding): This occurs when a subclass provides a specific implementation 
of a method that is already defined in its superclass. The method in the subclass overrides the method in 
the superclass. During runtime, the method to be executed is determined by the actual object being referred to.
Example:Animal In the above example, if you have an object of Animal class but it refers to a Dog object,
 calling the sound() method will execute the sound() method from the Dog class, not from the Animal class. This is determined at runtime.
Polymorphism allows for more flexible and modular code, as it enables code reuse, abstraction, and separation of concerns.*/

class Calculator {
    int add(int a, int b) {
        return a + b;
    }

    double add(double a, double b) {
        return a + b;
    }
}


class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    void sound() {
        System.out.println("Dog barks");
    }
}

