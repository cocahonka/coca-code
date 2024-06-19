void operators() {
  //* Арифметические операторы
  //* + - * / % ~/

  //* Префиксные и постфиксные операторы
  //* ++ --

  //* Операторы сравнения и равенства
  //* == != > < >= <=

  //* Логические операторы
  //* && || !

  //* Побитовые операторы
  //* & | ^ ~ << >>

  //* Операторы присваивания
  //* = += -= *= /= %= ~/=

  // Примеры:
  var a = 22;
  var b = 6;

  print('a % b = ${a % b}');
  print('a ~/ b = ${a ~/ b}');

  //* Префиксные и постфиксные операторы
  //* prefix - значение высчитывается до присваивания
  //* postfix - значение высчитывается после присваивания
  // Наглядный пример
  print('++a + b = ${++a + b}');
  print('a = $a');
  print('a++ + b = ${a++ + b}');
  print('a = $a');

  //* Операторы присваивания
  b = 10;
  b *= 5; // b = b * 5
  //! b /= 5; // b = b / 5
  b %= 5; // b = b % 5
  b ~/= 5; // b = b ~/ 5

  //* Оператор доступа ко встроенным методам и полям объекта
  const text = 'Hello, World!';
  print('Length of text: ${text.length}');
  print('First letter of text: ${text.substring(2, 6)}');
  const number = -42;
  print('Number is even: ${number.isEven}');
  print('Number is odd: ${number.abs()}');
}

void conditionExpressions() {
  //* if (CONDITION) { ... } - если условие верно, то выполняется блок кода
  //* else if (CONDITION) { ... } - если предыдущее условие не верно, то проверяется это условие
  //* else { ... } - если условие не верно, то выполняется блок кода
  //* CONDITION ? TRUE : FALSE - тернарный оператор

  //* || - логическое ИЛИ (ленивое ИЛИ)
  //* | - побитовое ИЛИ
  //* && - логическое И (ленивое И)
  //* & - побитовое И
  //* ! - логическое НЕ

  // Пример:
  const number = 42;

  if (number > 0 && number < 100) {
    print('Number is between 0 and 100');
  } else if (number > 100 && number < 1000) {
    print('Number is between 100 and 1000');
  } else {
    print('Number is out of range');
  }

  if (number > 0 || lazyTest(1)) {
    print('Number is greater than 0');
  }

  if ((number > 0) | lazyTest(2)) {
    print('Number is greater than 0');
  }

  if (number > 100 && lazyTest(3)) {
    print('Number is less than 100');
  }

  if ((number > 100) & lazyTest(4)) {
    print('Number is less than 100');
  }

  //* Если действие после if однострочное, то можно опустить фигурные скобки
  if (number > 0) print('Number is greater than 0');

  //* Тернарный оператор
  const isPositive = number > 0 ? 'positive' : 'negative';
  print('Number is $isPositive');

  //! Так лучше не делать, ухудшает читаемость кода
  number > 0 ? print('Number is positive') : print('Number is negative');

  // Пример:
  if (number > 0) {
    if (number < 100) {
      print('Number is between 0 and 100');
    } else {
      print('Number is greater than 100');
    }
  }

  // Лучше так:
  if (number > 0 && number < 100) {
    print('Number is between 0 and 100');
  } else if (number > 100) {
    print('Number is greater than 100');
  }

  // Пример 2
  if (number > 0) {
    if (number < 100) {
      if (number.isEven) {
        print('Number is even');
      } else {
        print('Number is odd');
      }
    } else {
      print('Number is greater than 100');
    }
  }

  // Лучше так:
  if (number > 0 && number < 100) {
    print('Number is ${number.isEven ? 'even' : 'odd'}');
  } else if (number > 100) {
    print('Number is greater than 100');
  }

  //? Различие между C++
  //? Нет :)

  //; Советы
  //; 1. Избегайте проблемы "пирамиды", когда условий много и они вложены друг в друга
  //; 2. Не делайте слишком много условий в одном блоке, лучше создать отдельные функции или переменные
  //; 3. Используйте однострочные условия, если это возможно

  //? Где switch-case?
  //? Switch-case без Patterns неудобен и излишен
  //? лучше использовать if-else и тернарный оператор
}

void flowControl() {
  //* for (VAR(S); CONDITION; EXPRESSION) { ... } - цикл for
  //* while (CONDITION) { ... } - цикл while
  //* do { ... } while (CONDITION) - цикл do-while
  //* break - выход из цикла
  //* continue - переход к следующей итерации

  // Пример:
  for (var i = 0; i < 10; i++) {
    print('Iteration $i');
  }

  for (var i = 0, twoPow = 1; i <= 10; i++, twoPow *= 2) {
    print('Iteration $i : $twoPow');
  }

  //! Не советую такое использовать, так как ухудшает читаемость кода
  for (var i = 0, content = ''; i < 10; i++, content += '*') {
    print('Iteration $i : $content');
  }

  var i = 0;
  while (i < 10) {
    print('While $i < 10');
    i++;
  }

  i = 10;
  while (i > 10) {
    print('While $i > 10');
    i++;
  }

  i = 0;
  do {
    print('Do-while $i < 10');
    i++;
  } while (i < 10);

  i = 10;
  do {
    print('Do-while $i > 10');
    i++;
  } while (i > 11);

  // Пример 2:
  for (var i = 0; i < 10; i++) {
    if (i.isEven) {
      print('Even number $i');
    } else {
      print('Odd number $i');
    }
  }

  // Лучше так:
  // Как?

  // Пример 3:
  for (var i = 0; i < 10; i++) {
    if (i.isEven) {
      if (i > 5) {
        print('Even number $i is greater than 5');
      } else {
        print('Even number $i is less than 5');
      }
    } else {
      if (i > 5) {
        print('Odd number $i is greater than 5');
      } else {
        print('Odd number $i is less than 5');
      }
    }
  }

  // Лучше так:
  // Как?

  //* continue и break
  for (var i = 0; i < 10; i++) {
    if (i.isEven) continue;
    if (i > 5) break;

    print('Odd number $i');
  }

  //? Различие между C++
  //? Нет :)

  //; Советы
  //; 1. Все смысловые блоки в for можно опустить
  //; 2. Циклы while стоит использовать если НЕ нужен иницилизатор И итератор
}

void asserts() {
  //* assert(CONDITION) - проверка условия, если условие не верно, то программа завершается с ошибкой
  //* assert(CONDITION, MESSAGE) - проверка условия, если условие не верно, то программа завершается с ошибкой и выводится сообщение

  //? Ассерты нужны для тестирования кода, чтобы проверить, что все работает правильно
  //? Они автоматически убираются из кода при компиляции в релиз
  //? Т.е. это определнный вид подсказок для разработчика
  //? В то время как тесты проверяют правильность работы программы
  //? Ассерты обычно убеждаются в том, что код работает правильно (проверка аргументов, возвращаемых значений и т.д.)

  // Пример:
  const number = 42;
  assert(number > 0, 'Number is less than 0');
  assert(number < 100, 'Number is greater than 100');

  // Пример 2:
  const text = 'Hello, World!';
  assert(text.isNotEmpty, 'Text is empty');
  assert(text.length > 10, 'Text is too short');

  // Пример 3:
  const isTrue = true;
  assert(isTrue, 'isTrue is false');
  assert(!isTrue, 'isTrue is true');
}

bool lazyTest(int index) {
  print('Проверка ленивости №$index');
  return true;
}

void main() {
  operators();
  conditionExpressions();
  flowControl();
  asserts();
}

// **Домашнее задание #2 - Flow**

// **Задание:**
// 1. FizzBuzz - ввести число и вывести все числа от 1 до введенного числа,
// - если число делится на 3, то вместо числа вывести Fizz,
// - если на 5 - Buzz,
// - если на 3 и 5 - FizzBuzz

// 2. Вывести все простые числа от 1 до 100 исключая те, сумма цифр которых четна

// 3. Вывести все високосные года в диапозоне от 1900 до 2024

/*
void main() {
  for (final action in [first, second, third]) {
    action();
  }
}

void first() {}

void second() {}

void third() {}
*/
