// ignore_for_file: cascade_invocations

import '12.abstraction.dart';

//? Имплементация
class Teacher2 implements Person {
  Teacher2({required this.name, required this.age, required this.subject});

  @override
  final String name;

  @override
  final int age;

  final String subject;

  @override
  void greet(Person other) {
    print('Shut up ${other.name}');
  }

  //; Приватного метода тут нет, соответственно переопределять нечего
}

//? Нарушение транзитивности
//! The class 'User' can't be implemented outside of its library because it's a base class.
// class Moderator implements User {}

base class Moderator extends User {
  Moderator(super.name);

  @override
  void greet(User other) {
    print('Hello, ${other.name}');
  }
}

//? Ошибка абстрактных приватных полей
final class PrivateAbstractionErrorImpl2 extends PrivateAbstractionError {
  //* Приватный метод вне видимости
}

//* The class 'PrivateAbstractionErrorFixed' can't be extended outside of its library because it's a final class.
// final class PrivateAbstractionErrorFixedImpl2 extends PrivateAbstractionErrorFixed {}

void main() {
  final teacher = Teacher2(name: 'John', age: 30, subject: 'Math');
  final moderator = Moderator('Alice');

  teacher.greet(teacher);
  moderator.greet(moderator);

  final privateAbstractionError = PrivateAbstractionErrorImpl2(); // Ошибки нету
  privateAbstractionError.publicMethod(); //! Ошибка новичка
}
