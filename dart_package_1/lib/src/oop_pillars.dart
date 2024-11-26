// Encapsulation
class Animal {
  String _name;
  Animal(this._name);
  String get name => _name;
  set name(String value) => _name = value;
  void makeSound() {
    print('Animal makes a sound.');
  }
}

// Abstraction
abstract class Vehicle {
  void start();
  void stop();
}

// Inheritance
class Dog extends Animal {
  Dog(String name) : super(name);
  @override
  void makeSound() {
    print('$name says: Woof! Woof!');
  }
}

class Car extends Vehicle {
  @override
  void start() {
    print('Car is starting.');
  }

  @override
  void stop() {
    print('Car has stopped.');
  }
}

void main() {
  var dog = Dog('Buddy');
  print('Dog\'s Name: ${dog.name}');
  dog.name = 'Max';
  print('Updated Dog\'s Name: ${dog.name}');
  dog.makeSound(); // Polymorphism
  var car = Car();
  car.start();
  car.stop();
}
