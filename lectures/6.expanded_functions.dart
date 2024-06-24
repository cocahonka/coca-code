// ignore_for_file: unnecessary_statements, unused_local_variable, prefer_function_declarations_over_variables, prefer_final_locals, omit_local_variable_types, unused_element, unnecessary_lambdas, cascade_invocations

import 'dart:math';

void anonymousFunctions() {
  //* Анонимные функции - это функции без имени

  //* Преимущества
  //? 1. Краткость
  //? 2. Читаемость
  //? 3. Возможность писать в функциональном стиле (фильтры, преобразователи и т.д.)

  //* Синтаксис
  //? (параметры) { тело функции }
  //? (параметры) => возвратное значение

  //? Возращаемый тип определяется автоматически

  //* Примеры
  //; 1. Создание анонимной функции
  (int a, int b) {
    return a + b;
  };

  (int a, int b) => a + b;
  // Этот пример не несет смысловой нагрузки, так как мы не сохраняем и не запускаем функцию

  //; 2. Создание и вызов анонимной функции
  //* Синтаксис
  //? (параметры) { тело функции }(аргументы)
  //? ((параметры) => возвратное значение)(аргументы)
  (String name) {
    print('Hello $name');
  }('Habuba');

  ((String name) => print('Hello $name'))('Habuba');

  // 2 пример как и первый не несет смысловой нагрузки, так как мы не сохраняем функцию
  // А значит мы можем развернуть функцию, т.е просто исполнить ее содержимое
  print('Hello Habuba');

  //; 3. Сохранение анонимной функции
  //? Работают все правила и синтаксисы, что и у обычных переменных
  var sumFunction = (int a, int b) {
    return a + b;
  };

  sumFunction = (int a, int b) => a + b;

  // sumFunction = (int a, int b, int c) => a + b + c; //! Ошибка - несовпадение типов перемменных

  print(sumFunction(1, 2));

  //? Функциональный тип
  int Function(int, int) anotherSumFunction = sumFunction;
  String Function(int, {required String name}) namedFunction = (int someInt, {required String name}) => name * someInt;
  double Function(double, [double]) powFunction = (double x, [double e = 1]) {
    return pow(x, e).toDouble();
  };
  //? Конечно же, предпочтительнее использовать модификаторы переменных (final, var)
  //? Функция не может быть const!

  //; 4. Функция как выходной и входной параметр
  int Function(int) adder(int numberToAdd) {
    return (int number) => number + numberToAdd;
  }

  final add5 = adder(5);
  print(add5(11));

  List<int> filter({
    required bool Function(int) predicate,
    required List<int> list,
  }) {
    final filteredList = <int>[];
    for (final el in list) {
      if (predicate(el)) filteredList.add(el);
    }
    return filteredList;
  }

  final evenNumbers = filter(
    predicate: (int number) => number.isEven,
    list: [for (var i = 0; i < 10; ++i) i],
  );
  print(evenNumbers);

  //; 5. Полная польза typedefs
  //? Так как анонимные функции не имеют имени, то их сложно использовать в качестве типов
  //? Запись типа функции как входного и(или) выходного значения занимает много места

  int? findOrNull({
    required IntPredicate predicate,
    required List<int> list,
  }) {
    for (final el in list) {
      if (predicate(el)) return el;
    }
    return null;
  }

  int findOrElse({
    required IntPredicate predicate,
    required List<int> list,
    required IntGetter orElse,
  }) {
    // 1. Использовать findOrNull
    // 2. Использовать IntGetter (допустим мы хотим что то допом посчитать)
    throw UnimplementedError();
  }
}

typedef VoidCallback = void Function();
typedef IntSetter = void Function(int);
typedef IntGetter = int Function();
typedef IntPredicate = bool Function(int);

typedef Microvawe = void Function(int timer, [String? dish]);
typedef MicrovaweFactory = Microvawe Function(int power);

void closures() {
  //* Замыкания - это функции, которые могут захватывать переменные из окружающей области видимости
  //* Т.е. Замыкания - это следствие Lexical Scope (лексической области видимости)

  //* Замыкания можно представить как класс, у которого есть поля и методы
  //* Переменные которые замыкаются - это поля класса
  //* Функции, которые возвращаются из замыкания - это методы класса

  // Пример со счетчиком
  IntGetter counter() {
    var count = 0;

    final increment = () {
      return ++count;
    };

    return increment;
  }

  final counter1 = counter();
  print(counter1()); // 1
  print(counter1()); // 2
  print(counter1()); // 3

  // Пример с фабрикой микроволновок
  MicrovaweFactory microvaweFactory(String brand) {
    var modelNumber = 1;

    String getModelName(int power) {
      return '$brand PW-$power ${modelNumber.toString().padLeft(4, 'X')}';
    }

    return (int power) {
      final modelName = getModelName(power);
      print('Создана микроволновка: $modelName');
      modelNumber++;

      return (int timer, [String? dish]) {
        final work = dish == null ? 'работает' : 'готовит $dish';
        print('Микроволновка $modelName $work $timer секунд');
      };
    };
  }

  final xiaomiFactory = microvaweFactory('Xiaomi');
  final samsungFactory = microvaweFactory('Samsung');

  final xiaomiMicrovawe = xiaomiFactory(800);
  final samsungMicrovawe = samsungFactory(1000);

  xiaomiMicrovawe(30, 'Картошку');
  xiaomiMicrovawe(60, 'Курицу');
  xiaomiMicrovawe(10);

  samsungMicrovawe(30, 'Картошку');
  samsungMicrovawe(20);

  final newXiaomiMicrovawe = xiaomiFactory(1200);
  newXiaomiMicrovawe(30, 'Картошку');
  xiaomiMicrovawe(30, 'Картошку');
  samsungMicrovawe(30, 'Картошку');

  //; Возможно вам будет не понятно где такое использовать
  //; Но на самом деле вы используете это постоянно и не замечаете
}

void builtinAnonymousFunctions() {
  final generator = Random();
  //* Использование анонимных функций в STD Dart

  //; List
  //* Генератор
  final list = List<int>.generate(
    10,
    (index) => index,
  );

  final randomList = List<int>.generate(
    10,
    (_) => generator.nextInt(101),
  );

  // Аналогично
  final oldList = [
    for (var i = 0; i < 10; i++) i,
  ];

  final oldRandomList = [
    for (var i = 0; i < 10; i++) generator.nextInt(101),
  ];

  //* Методы
  //? where (фильтр) - фильтрация
  final evenList = list.where((element) => element.isEven);
  final primeList = list.where((element) => isPrime(element));
  // Передача ссылки на функцию
  final anotherPrimeList = list.where(isPrime);

  //? any (хотя бы один), every (все) - проверки
  final isAnyGreaterThan5 = list.any((element) => element > 5);
  final isAllIsPrime = list.every(isPrime);

  //? map - преобразование
  final barCodedList = list.map((element) => 'barcode-${element.hashCode}');
  final powedBy2List = list.map((element) => element * element);

  //? reduce, fold - свертка (преобразование в одно значение)
  //? Различия fold и reduce:
  //? 1. У fold есть начальное значение
  //? 2. reduce обязан вернуть тип элемента коллекции, а fold может вернуть любой тип
  //? 3. reduce не может быть вызван на пустой коллекции
  final sum = list.reduce((prev, next) => prev + next);
  final multiply = list.skip(1).take(5).reduce((prev, next) => prev * next);

  final barCodedSummaryLength = barCodedList.fold(
    0,
    (prev, next) => prev + next.length,
  );

  //? removeWhere, sort - мутатор
  final onlyPrimeNumbers = [...list];
  onlyPrimeNumbers.removeWhere((element) => !isPrime(element));

  final descendingList = [...list];
  // descendingList.sort(); // Сортирует по возрастанию
  descendingList.sort((a, b) => b.compareTo(a));

  //? forEach - итератор
  final students = ['Habuba', 'Marcus', 'Ivan', 'Paul', 'BoldMan (Dota2)'];
  students.forEach(print);

  final namedResults = {
    'even': evenList,
    'prime': primeList,
    'isAnyGreaterThan5': isAnyGreaterThan5,
    'isAllIsPrime': isAllIsPrime,
    'barCoded': barCodedList,
    'powedBy2': powedBy2List,
    'sum': sum,
    'multiply': multiply,
    'barCodedSummaryLength': barCodedSummaryLength,
    'onlyPrimeNumbers': onlyPrimeNumbers,
    'descendingList': descendingList,
  };

  namedResults.forEach((name, output) => print('$name: $output'));

  //? И множество других...
  // Например для карт
  final someMap = <String, int>{'Paul': 20};
  final paul = someMap.putIfAbsent('Paul', () => 21);
  final george = someMap.putIfAbsent('George', () => 18);
  print('paul $paul || george $george');

  //; Использование встроенных методов упрощает код и делает его приятным для чтения
  //; Практически все можно сделать через эти методы (но при сложной логике придется делать по старинке)
  //; Вывод - пытаемся сделать все через встроенные методы (если это возможно)
}

void cascadeOperator() {
  //* Каскадные операторы - это способ вызвать метод у объекта и вернуть объект обратно, а не результат метода
  //* Синтаксис - .. (две точки)

  // Пример
  final list = List.generate(10, (i) => i);
  // listLength - int - так как возвращается length
  final listLength = list.length;

  // sortedList - List<int> - так как возвращается list, хотя метод sort() возвращает void
  final sortedList = [...list]..sort();

  //* Пример продвинутого использования
  // Задача (заранее неизвестен порядок чисел в массиве):
  // 1. Отфильтровать значения которые меньше или больше 50
  // 2. Убрать все нечетные элементы
  // 3. Отсортировать по убыванию
  // 4. Возвести в квадрат
  final generator = Random();
  final offset = List.generate(20, (index) => generator.nextInt(101));

  final advancedListTrue = (offset.where((element) => element <= 50).toList()
        ..removeWhere((element) => element.isOdd)
        ..sort((a, b) => b.compareTo(a)))
      .map((element) => element * element)
      .toList();

  final advancedListFalse = offset.where((element) => element <= 50).toList()
    ..removeWhere((element) => element.isOdd)
    ..sort((a, b) => b.compareTo(a))
    ..map((element) => element * element);

  print(advancedListFalse);

  //; Используйте каскадные операторы в следующих случаях
  //; 1. Вам не нужен результат метода
  //; 2. Вам нужно мутировать состояние объекта
  //; Именно поэтому всё до map обернуто в каскадный оператор
  //; Если бы map тоже был каскадным то мы бы не получили результат
}

void syncStar() {
  //* Что такое Iterable
  //? Iterable - это коллекция, которая может быть перебрана (итерирована)
  //? Iterable - это абстрактный класс, который определяет методы для работы с коллекциями
  //? Iterable - это базовый класс для List, Set, Map и других коллекций
  //? Iterable не имеет методов для мутации коллекции, не имеет индексации и не имеет длины

  //* Почему когда мы вызываем методы у List, то они возвращают Iterable, а не List?
  //? Iterable - некоторая оптимизация (ленивый List)
  //? Iterable - не хранит значения, а генерирует их по мере необходимости
  //? То есть если мы за всю программу не используем какие-то значения, то они и не будут сгенерированы
  //? Но напрямую создать Iterable нельзя, так как тогда самим писать оптимизрованные методы как у List?
  //? Ответ - синхронные генераторы (sync*)

  //* Синхронные генераторы - это функции, которые могут генерировать значения по мере необходимости
  //* Синхронные генераторы - это функции, которые возвращают Iterable
  //* Синхронные генераторы могут быть рекурсивными

  //* Синтаксис
  //* Iterable<type> functionName(args...) sync* { yield value; }
  //* yield - ключевое слово, которое генерирует значение
  //* yield* - ключевое слово, которое генерирует последовательность

  //* Обычно взаимодействие происходит с помощью take и skip

  // Пример
  Iterable<int> fibonacci() sync* {
    var (a, b) = (0, 1);
    while (true) {
      yield a;
      (a, b) = (b, a + b);
    }
  }

  Iterable<int> fibonacciButTrashInFron() sync* {
    for (var i = 0; i < 10; ++i) {
      yield i;
    }
    yield* fibonacci();
  }

  print(fibonacci());
  print(fibonacci().take(10));
  print(fibonacci().skip(10).take(3));
  print(fibonacci().where(isPrime).take(10));

  // Пример
  Iterable<int> range(int start, int end) sync* {
    for (var i = start; i <= end; i++) {
      yield i;
    }
  }

  print(
    range(100, 1000).where((e) {
      final str = e.toString().split('');
      return str.first == str.last;
    }).take(10),
  );

  //* Методы map, where, forEach и другие работают с sync*

  // Реализуем свой where
  //! ...

  //* Рекурсивный sync*
  //* используется yield* для вызова другого sync* генератора
  //* yield* должен возращать полную последовательность (можно использовать не только для рекурсии)

  // Пример
  Iterable<int> recursiveFibonacci([int a = 0, int b = 1]) sync* {
    yield a;
    yield* recursiveFibonacci(b, a + b);
  }

  print(recursiveFibonacci().take(10));

  // Пример
  Iterable<Iterable<int>> fibonacciMatrix(int n, [int i = 0]) sync* {
    if (i == n) return;
    yield fibonacci().skip(i * n).take(n);
    yield* fibonacciMatrix(n, i + 1);
  }

  void printLazyMatrix(Iterable<Iterable<int>> matrix) {
    for (final row in matrix) {
      print(row.toList());
    }
  }

  printLazyMatrix(fibonacciMatrix(5));

  //; Пример матрицей фибоначи не стоит использовать, так как мы вызываем fibonacci каждый раз заного
  //; Т.е. у нас отсуствует мемоизация, что плохо для производительности
}

void main() {
  anonymousFunctions();
  builtinAnonymousFunctions();
  closures();
  cascadeOperator();
  syncStar();
}

bool isPrime(int number) {
  if (number <= 1) return false;

  for (var i = 2; i <= sqrt(number).toInt(); i++) {
    if (number % i == 0) return false;
  }

  return true;
}

//; Везде НЕ использовать typedefs кроме 2 задания на замыкание
//; 1 (1 задача)
// Задача на простую анонимную функцию
// Функция возвращает новый массив строк
// Функция принимает массив строк, функцию предикат и функцию мутатор
//
// Последовательно наполняется новый массив который удовлетворяет предикату
// После заполнения (можно и во время) строки которые удолетворяют предикату
// Мутируются с помощью функции мутатора (изменяются, а точнее перезаписываются или вставляются)

//; 2 (1 задача)
// Задача на замыкание (используйте typedef)
// Фукнция ничего не принимает
// Функция возвращает функцию X (сами подберите подходящее имя)
// Фукнция X принимает строку и возвращает строку
//
// Должна замыкаться переменная numBuildings
// При каждом вызове функции X из main должно увеличиваться значение numBuildings на 1
// Функция X должна печатать в консоль что было добавлено новое здание
// Далее функция X должна возвращать строку с привественым сообщением и количество зданий
// Показать что будет если создать две фукнции X
//
// Пример (измените вывод)
// funcX = func()
// a = funcX()
// print(a)
// b = funcX()
// c = funcX()
// print(a)
// print(b)
// Вывод следующий
// Добавлен дом
// Привет Мэр, у вас 1 здание
// Добавлен дом
// Добавлен дом
// Привет Мэр, у вас 3 здания
// Привет Мэр, у вас 3 здания

//; 3 (3 задачи)
// Задачи на STD
// 1. https://exercism.org/tracks/dart/exercises/armstrong-numbers
// 2. https://leetcode.com/problems/richest-customer-wealth/
// 3. https://exercism.org/tracks/dart/exercises/luhn
// Решать локально, а не на сайтах.
// Сайты только для условий

//; 4 (2 задачи)
// Задачи на sync* (используйте int)
// 1. Написать генератор чисел от start до end, где первая и последняя цифра одинаковы

// 2. Написать генератор intSkipWhile которая принимает Iterable<int> и именованный предикат
// Генератор должнен пропускать значения пока предикат не вернет false
// Далее генератор должен возвращать все оставшиеся значения
//! Не использовать встроенный skipWhile и takeWhile!
//! Сделать два решения с yield и yield*

// Задача на рекурсивный sync* (1 задача)
// Доделайте этот код чтобы получился треугольник паскаля
// P.s данный подход не оптимален, но он хорошо показывает как работает sync*
// P.s.s вызывайте в мейне generatePascalTriangle
// P.s.s while и for пользоваться запрещено

/*

/// Функция генерирует треугольник Паскаля и возвращает его в виде двумерного листа
List<List<int>> generatePascalTriangle(int numRows) => generateRows().take(numRows).map((e) => e.toList()).toList();

/// Синхронный рекурсивный генератор строк треугольника Паскаля
Iterable<Iterable<int>> generateRows([Iterable<int> prevRow = const []]) sync* {
  // Тут ваш код
}

/// Синхронный генератор новой строки треугольника Паскаля
Iterable<int> generateNewRow(Iterable<int> prevRow) sync* {
  // Тут ваш код
}

/// Функция получения нового значения в строке треугольника Паскаля
int generateValue(int index, Iterable<int> prevRow) {
  // Тут ваш код
}

*/
