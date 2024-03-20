 polymorphism in Python 

Python Example:
Method Overloading (Compile-time Polymorphism):
python

class Calculator:
    def add(self, a, b):
        return a + b

    def add(self, a, b, c):
        return a + b + c

calc = Calculator()
print(calc.add(2, 3))      # This will raise an error in Python
print(calc.add(2, 3, 4))   # This will work fine
Python does not directly support method overloading like Java or C++,
 but you can achieve similar functionality by using default parameter values or variable-length argument lists.

Method Overriding (Run-time Polymorphism):
python
Copy code
class Animal:
    def sound(self):
        print("Animal makes a sound")

class Dog(Animal):
    def sound(self):
        print("Dog barks")

animal = Animal()
animal.sound()  # Output: Animal makes a sound

dog = Dog()
dog.sound()     # Output: Dog barks











Ruby Example:
Method Overloading (Compile-time Polymorphism):
ruby
Copy code
class Calculator
  def add(a, b)
    a + b
  end

  def add(a, b, c)
    a + b + c
  end
end

calc = Calculator.new
puts calc.add(2, 3)        # This will raise an error in Ruby
puts calc.add(2, 3, 4)     # This will work fine
Method Overriding (Run-time Polymorphism):
ruby
Copy code
class Animal
  def sound
    puts "Animal makes a sound"
  end
end

class Dog < Animal
  def sound
    puts "Dog barks"
  end
end

animal = Animal.new
animal.sound   # Output: Animal makes a sound

dog = Dog.new
dog.sound      # Output: Dog barks
In both Python and Ruby, method overloading isn't directly supported like in Java,
 but you can achieve similar behavior through different means. However, method overriding
  for achieving run-time polymorphism is supported in both languages.

User
code javascript
ChatGPT
Certainly! Here are the examples of polymorphism in JavaScript:

Method Overloading (Compile-time Polymorphism):
JavaScript does not support method overloading in the same way as languages like Java or C++.
 However, you can achieve similar behavior by checking the number of arguments passed and implementing different logic accordingly.

javascript
Copy code
class Calculator {
    add(a, b, c) {
        if (arguments.length === 2) {
            return a + b;
        } else if (arguments.length === 3) {
            return a + b + c;
        }
    }
}

const calc = new Calculator();
console.log(calc.add(2, 3));        // Output: 5
console.log(calc.add(2, 3, 4));     // Output: 9
Method Overriding (Run-time Polymorphism):
JavaScript supports method overriding for achieving run-time polymorphism.

javascript
Copy code
class Animal {
    sound() {
        console.log("Animal makes a sound");
    }
}

class Dog extends Animal {
    sound() {
        console.log("Dog barks");
    }
}

const animal = new Animal();
animal.sound();   // Output: Animal makes a sound

const dog = new Dog();
dog.sound();      // Output: Dog barks
In JavaScript, you can define methods with the same name in the same class, 
but only the last method definition will take effect, effectively overriding the previous ones. 
This allows you to achieve polymorphic behavior similar to method overriding in other object-oriented languages.




