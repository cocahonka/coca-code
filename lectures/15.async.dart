// ignore_for_file: discarded_futures, unawaited_futures

import 'dart:async';
import 'dart:convert' show Utf8Decoder;
import 'dart:io' show HttpClient, HttpClientRequest;
import 'dart:math';

extension StringX on String {
  String get shrink => '${substring(0, min(length, 20))}...';
}

void begin() {
  //? Асинхронность в Dart

  //; Весь ваш код на Dart выполняется в изоляте

  //; Изолят можно воспринимать как поток¹ с изолированной от других потоков памятью
  //* 1. Поток - как абстракция Dart VM, а не системный поток.

  //; Concurrency - одновременное управление несколькими задачами
  //* Частные случаи concurrency: parallelism (параллелизм) и asynchronicity (асинхронность)

  //; Параллелизм - выполнение нескольких задач одновременно (на разных ядрах)

  //; Асинхронность - способ организовать concurrency без реального параллелизма (псевдопараллелизм на одном ядре)
  //; Асинхронность - непоследовательное выполнение кода (возможность совершать неблокирующие операции)
  //; Асинхронный код - код, который может быть приостановлен и продолжен позже

  // https://ibb.co/7dygy8TG

  //? Программа на Dart работает однопоточно...
}

void confusion() {
  //? ...Программа на Dart работает многопоточно!

  //; Весь ваш³ код на Dart² выполняется в изоляте¹
  //* 1. Необязательно в одном. Можно создавать дополнительные изоляты
  //* 2. Можно вызывать код не на Dart (ffi, platform channel), который будет создавать свои потоки
  //* 3. Любой чужой код может делать все вышеперечисленное
  //; 3. Операции с сетью и файловой системой идут через Dart VM (C++) и выполняются параллельно, используя пул потоков Dart VM

  //? Способы реализации concurrency в Dart:
  //* Параллелизм - Isolate (без общей памяти!)
  //* Асинхронность - Event loop
}

void eventLoop() {
  //? Event loop - это механизм обработки событий, который позволяет писать неблокирующий код
  //* Event loop - состоит из очереди микротасок и очереди событий и циклически обрабатывает их (https://ibb.co/tM4ck2jZ)

  //? Основные положения:
  //* 1. У каждого изолята есть свой Event loop
  //* 2. В Event loop попадают все асинхронные операции
  //* 3. Event loop делает итерацию после окончания синхронного кода или вызова прерывания
  //* 4. Программа завершится, когда все микротаски и события будут обработаны, а также не будет активных асинхронных источников

  //* Взаимодействие с Event loop, то есть с асинхронным кодом, происходит через Future API (dart:async)

  //; Если Event Loop – это обычный синхронный цикл, очередь событий – это FIFO структура,
  //; а Future Api — интерфейс для создания событий в очереди, то что во всём этом асинхронного?
  //; Ответ - ничего)

  //* Все синхронно, только теперь некоторые операции можно откладывать на потом
  //* Таким образом можно намертво заблокировать Event loop, если засунуть туда тяжёлую задачу
}

void futureApi() {
  //? Future<T> - специальный класс, который представляет собой результат асинхронной операции
  //* Значение внутри Future будет доступно не сразу, а позже (в будущем), после завершения асинхронной операции

  //* С помощью Future можно создавать как события, так и микротаски
  //* Future работает через класс Timer
  //* Timer - ядро Future API, которое напрямую взаимодействует с Event loop через Dart VM (C++)
}

void defaultTimer() {
  // Стандартный конструктор Timer
  print('Default timer sync code started');

  Timer(const Duration(seconds: 2), () {
    print('Hello from Timer!');
  });

  print('Default timer sync code finished');
}

void timerRun() {
  // Конструктор Timer.run, запускающий код сразу после завершения синхронного кода
  print('Timer.run sync code started');

  Timer.run(() {
    print('Hello from Timer.run!');
  });

  print('Timer.run sync code finished');
}

void periodicTimer() {
  // Конструктор Timer.periodic, запускающий код через определенные интервалы времени
  print('Periodic timer sync code started');

  Timer.periodic(const Duration(milliseconds: 500), (timer) {
    print('Hello from Timer.periodic!');
    if (timer.tick == 5) {
      //* Таймер можно отменять!
      timer.cancel();
    }
  });

  Timer.run(() => print('Hello from Timer.run!'));

  print('Periodic timer sync code finished');
}

void pseudoFuture() {
  // Попробуем реализовать Future самостоятельно
  final pseudoFuture = PseudoFuture(
    duration: const Duration(milliseconds: 500),
    callback: () {
      return 42;
    },
  );

  print(pseudoFuture.value);

  Timer(const Duration(seconds: 1), () => print(pseudoFuture.value));
}

base class PseudoFuture<T extends Object> {
  PseudoFuture({required this.duration, required this.callback}) {
    _timer = Timer(duration, () {
      _result = callback();
    });
  }

  final Duration duration;
  final T Function() callback;

  late final Timer _timer;
  late final T _result;

  T? get value => _timer.isActive ? null : _result;
}

void simpleFuture() {
  // Стандартный конструктор Future
  print('Simple future sync code started');

  //* Добавит событие (event) в event loop
  Future(() {
    print('Hello from Future!');
  });

  print('Simple future sync code finished');
}

void futureThen() {
  // Чтобы получить результат Future, можно использовать метод then
  // then вызывается моментально после завершения Future!
  print('Simple future then sync code started');

  final future = Future(() {
    print('Hello from Future.then!');
    return 42;
  });

  future.then((value) => print('Value: $value'));

  Future(() => 52).then(print);

  print('Simple future then sync code finished');
}

void futureCatch() {
  // Чтобы обработать ошибку Future, можно использовать метод onError или catchError
  // onError предпочтительнее, так как у него типизированный аргумент
  print('Simple future catch sync code started');

  final future = Future(() {
    print('Hello from Future.onError!');
    throw Exception('Error!');
    // ignore: dead_code
    return 52;
  });

  future.then((value) => print('Value: $value')).onError((error, stask) {
    print('Error: $error');
  });

  print('Simple future catch sync code finished');
}

void futureIgnore() {
  // Чтобы игнорировать ошибки и результат Future, можно использовать метод ignore
  print('Simple future ignore sync code started');

  Future(() {
    print('Hello from Future.ignore!');
    throw Exception('Error!');
  }).then((value) => print('Value: $value')).ignore();

  print('Simple future ignore sync code finished');
}

void futureWhenComplete() {
  // Чтобы дождаться завершения Future (неважно со значением или ошибкой),
  // можно использовать метод whenComplete
  // whenComplete вызывается моментально после завершения Future!
  print('Simple future whenComplete sync code started');

  Future(() => 42).then(print).whenComplete(() {
    print('Future 1 completed!');
  });

  Future(() => throw Error()).then(print).whenComplete(() {
    print('Future 2 completed!');
  }).ignore();

  print('Simple future whenComplete sync code finished');
}

void futureConclusions() {
  //* У Future осталось еще два метода - asStream и timeout
  //? asStream - позволяет преобразовать Future в Stream
  //? timeout - позволяет установить таймаут для Future (очень редко используется)

  //; Future - НЕВОЗМОЖНО отменить
  //* Timer - можно отменить
}

void simpleMicrotask() {
  //* До этого мы использовали стандартный конструктор Future, который добавляет событие (event) в event loop
  //* Но мы также можем добавлять микротаски (microtask) в event loop
  //? Микротаски - это более легковесные задачи с большим приоритетом, чем у событий (event's)

  print('Simple microtask sync code started');

  // Микротаска
  Future.microtask(() {
    print('Hello from Future.microtask! 1');
  }).whenComplete(() => print('Future.microtask completed!'));

  // Событие
  Future(() {
    print('Hello from Future!');
  });

  // Микротаска
  scheduleMicrotask(() {
    print('Hello from scheduleMicrotask! 2');
  });

  print('Simple microtask sync code finished');

  //; Не стоит злоупотреблять микротасками, так как они нужны в редких и критических случаях
}

void callbackHell() {
  //? Callback hell - это ситуация, когда у вас много вложенных колбеков (callback), которые сложно читать и поддерживать

  final httpClient = HttpClient();
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  //* Хорошее применение `chain` методов than, onError и whenComplete
  httpClient
      .getUrl(url)
      .then((request) => request.close())
      .then((response) {
        if (response.statusCode == 200) {
          return response.transform(const Utf8Decoder()).join();
        } else {
          throw StateError('Failed to load post');
        }
      })
      .then((data) => print('Post data: ${data.shrink}'))
      .onError<StateError>((error, stack) => print('Status code error: $error'))
      .onError((error, stack) => print('Error: $error'));
  //.whenComplete(httpClient.close);

  //* Callback hell...
  final newUrl = Uri.parse('https://jsonplaceholder.typicode.com/');
  httpClient
      .getUrl(newUrl)
      .then((request) => request.close())
      .then((response) => response.transform(const Utf8Decoder()).join())
      .then((body) {
        print('Ответ на первый запрос: ${body.shrink}');
        final postUrl = Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/1',
        );
        httpClient
            .getUrl(postUrl)
            .then((request) => request.close())
            .then((response) => response.transform(const Utf8Decoder()).join())
            .then((postBody) {
              print('Ответ на второй запрос: ${postBody.shrink}');
              final userUrl = Uri.parse(
                'https://jsonplaceholder.typicode.com/users/1',
              );

              httpClient
                  .getUrl(userUrl)
                  .then((request) => request.close())
                  .then(
                    (response) =>
                        response.transform(const Utf8Decoder()).join(),
                  )
                  .then((userBody) {
                    print('Ответ на третий запрос: ${userBody.shrink}');
                    final commentUrl = Uri.parse(
                      'https://jsonplaceholder.typicode.com/comments/1',
                    );

                    httpClient
                        .getUrl(commentUrl)
                        .then((request) => request.close())
                        .then(
                          (response) =>
                              response.transform(const Utf8Decoder()).join(),
                        )
                        .then((commentBody) {
                          print(
                            'Ответ на четвёртый запрос: ${commentBody.shrink}',
                          );
                          print('Процесс завершён!');
                        })
                        .catchError((Object? e) {
                          print('Ошибка при запросе комментариев: $e');
                        })
                        .whenComplete(httpClient.close);
                  })
                  .catchError((Object? e) {
                    print('Ошибка при запросе пользователя: $e');
                  });
            })
            .catchError((Object? e) {
              print('Ошибка при запросе поста: $e');
            });
      })
      .catchError((Object? e) {
        print('Ошибка при первом запросе: $e');
      });
}

void callbackHellFix() {
  //* Вынесли общее поведение в отдельную функцию
  //* Но ситуация не сильно улучшилась, так как мы все равно используем вложенные колбеки
  final httpClient = HttpClient();
  final url = Uri.parse('https://jsonplaceholder.typicode.com/');
  final postUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final userUrl = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
  final commentUrl = Uri.parse(
    'https://jsonplaceholder.typicode.com/comments/1',
  );

  Future<void> performStandardOperation(
    Future<HttpClientRequest> future,
    FutureOr<void> Function(String) body,
  ) => future
      .then((request) => request.close())
      .then((response) => response.transform(const Utf8Decoder()).join())
      .then(body)
      .catchError((Object? e) {
        print('Ошибка при запросе: $e');
      });

  performStandardOperation(httpClient.getUrl(url), (body) {
    print('Ответ на первый запрос: ${body.shrink}');
    return performStandardOperation(httpClient.getUrl(postUrl), (postBody) {
      print('Ответ на второй запрос: ${postBody.shrink}');
      return performStandardOperation(httpClient.getUrl(userUrl), (userBody) {
        print('Ответ на третий запрос: ${userBody.shrink}');
        return performStandardOperation(httpClient.getUrl(commentUrl), (
          commentBody,
        ) {
          print('Ответ на четвёртый запрос: ${commentBody.shrink}');
          print('Процесс завершён!');
        });
      });
    });
  }).whenComplete(httpClient.close);
}

void asyncAwait() {
  //* До этого мы использовали Future API с помощью колбэков
  //* Но мы также можем использовать Future API с помощью async/await, чтобы писать в синхронном стиле

  //? async/await - это просто синтаксический сахар для работы с Future API, который скрывает коллбэки под капотом
  //* Ключевые понятия:
  //* Синхронная операция: Некая синхронная работа, которая блокирует исполнение последующего кода пока она не выполнится.
  //* Синхронная функция: Функция, которая может выполнять только синхронные операции.
  //* Асинхронная операция: Некая работа, которая может позволять другим операциям выполняться после ее старта и вплоть до завершения.
  //* Асинхронная функция: Функция, которая выполняет как минимум одну асинхронную операцию и неограниченное кол-во синхронных операций.

  //; Мы еще не рассматривали асинхронные операции!, так как все время в тело Future передавали синхронный код

  //* Чтобы создать асинхронную функцию, нужно добавить к функции ключевое слово async
  //* И любая асинхронная функция должна возвращать Future
}

void asyncAwaitSimpleExample() {
  print('Async await simple example sync code started');
  simpleAsyncFunction();
  print('Async await simple example sync code finished');
}

Future<void> simpleAsyncFunction() async {
  print('Simple async function');
}

void asyncAwaitConfusion() {
  //? Почему функция simpleAsyncFunction сработала синхронно?
  //* Расширим понятие асинхронной функции:
  //* Асинхронная функция: функция, выполнение которой может быть приостановлено с передачей управления назад в место вызова.
  //* Как только блокирующая операция выполнится, выполнение функции продолжится с места, где она была приостановлена.

  //* Приостановить выполнение асинхронной функции можно с помощью await
  //* await может дожидаться только выполнения Future

  //; Любая асинхронная функция выполняется синхронно до первого await
}

void asyncAwaitSecondExample() {
  print('Async await second example sync code started');
  simpleAsyncFunctionWithAwait();
  print('Async await second example sync code finished');
}

Future<void> simpleAsyncFunctionWithAwait() async {
  print('Simple async function with await');
  await Future(() => print('Hello from Future!'));
  print('Simple async function with await finished!');
}

Future<void> asyncCallbackHellFix() async {
  //? Исправим callback hell с помощью async/await
  final httpClient = HttpClient();
  final url = Uri.parse('https://jsonplaceholder.typicode.com/');
  final postUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final userUrl = Uri.parse('https://jsonplaceholder.typicode.com/users/1');

  var request = await httpClient.getUrl(url);
  var response = await request.close();
  var body = await response.transform(const Utf8Decoder()).join();
  print('Ответ на первый запрос: ${body.shrink}');

  request = await httpClient.getUrl(postUrl);
  response = await request.close();
  body = await response.transform(const Utf8Decoder()).join();
  print('Ответ на второй запрос: ${body.shrink}');

  request = await httpClient.getUrl(userUrl);
  response = await request.close();
  body = await response.transform(const Utf8Decoder()).join();
  print('Ответ на третий запрос: ${body.shrink}');

  //* Убираем повторения
  Future<String> getBodyByUrl(Uri url) async {
    final request = await httpClient.getUrl(url);
    final response = await request.close();
    return response.transform(const Utf8Decoder()).join();
  }

  print('Ответ на первый запрос: ${(await getBodyByUrl(url)).shrink}');
  print('Ответ на второй запрос: ${(await getBodyByUrl(postUrl)).shrink}');
  print('Ответ на третий запрос: ${(await getBodyByUrl(userUrl)).shrink}');

  //* Ловим ошибки
  try {
    final body = await getBodyByUrl(userUrl);
    print('Ответ на третий запрос: ${body.shrink}');
  } on Exception catch (e) {
    print('Ошибка при запросе пользователя: $e');
  } finally {
    print('Процесс завершён!');
  }

  //; Если не дождаться Future внутри try catch, то ошибка не будет поймана
  //; Для отлова ошибок от неожидаемых Future нужно использовать Zone

  httpClient.close();
}

Future<void> unawaitedFutureError() async {
  //* Пример неотловленной ошибки через then
  Future(() {
    Future(() => throw Exception());
  }).onError((error, stack) {
    print('Error: $error');
  });

  try {
    Future(() => throw Exception());
  } on Exception catch (e) {
    print('Error: $e');
  } finally {
    print('Finally block executed!');
  }
}

void futureOr() {
  //? FutureOr<T> - это специальный класс, который может быть либо Future<T>, либо T
  //* Нужен для того, чтобы в разных местах можно было не прерывать выполнение кода

  Future<void> action(FutureOr<int> value) async {
    if (value is Future<int>) {
      final result = await value;
      print('Result: $result');
    } else {
      print('Sync value: $value');
    }
  }

  action(Future.value(42));
  action(52);

  //; FutureOr активно используется в Future Api, но в повседневной жизни не так часто
}

Future<void> futureTypes() async {
  //? Future имеет множество конструкторов, каждый из которых имеет свои особенности

  //* Future(callback) - Добавляет callback как event в event loop
  //* Future.microtask(callback) - Добавляет callback как microtask в event loop
  //* Future.delayed(duration, callback) - Добавляет callback как event в event loop с задержкой

  //* Future.value(value) - Возвращает microtask с уже готовым значением
  Future.value(42).then(print);

  //* Future.sync(callback) - Синхронно выполняет callback, возращает microtask
  Future.sync(() {
    print('hello world');
    return 52;
  }).then(print);

  //* Future.error(error) - Возвращает microtask с ошибкой
  Future<Exception>.error(Exception()).ignore();

  //* Future.wait(futures) - Возвращает Future, который завершится, когда все futures завершатся
  Future.wait([
    Future(() => print('wait 1')),
    Future(() => print('wait 2')),
    Future(() => print('wait 3')),
    Future(() => print('wait 4')),
  ]).then((values) {
    print('Values: $values');
  });

  //* Future.any(futures) - Возвращает Future, который завершится, когда любой из futures завершится
  Future.any([
    Future(() => 42),
    Future.value(52),
    Future.delayed(const Duration(seconds: 1), () => 62),
  ]).then((value) {
    print('Any value: $value');
  });

  //* Future.forEach(elements, action) - Возвращает Future, который завершится, когда все элементы будут обработаны
  Future.forEach(
    [1, 2, 3],
    (v) => Future(() {
      print('transform $v');
      return v * 2;
    }),
  ).whenComplete(() => print('forEach done!'));

  //* Future.doWhile(action) - Возвращает Future, который завершится, когда action вернет false
  var count = 0;
  Future.doWhile(() async {
    print('doWhile with $count');
    await Future<void>.delayed(Duration.zero);
    count++;
    return count < 5;
  }).whenComplete(() => print('doWhile done!'));
}

Future<void> additionalMoments() async {
  //* then не всегда вызывается синхронно, если Future был уже выполнен до вызова then, то он будет вызван через микротаску

  final future = Future(() => 42);
  future.then((value) => print('Sync then')); // Выполнится синхронно
  Future.microtask(() => print('microtask'));

  await Future<void>.delayed(Duration.zero);

  future.then((value) => print('Micro then')); // Выполинится через микротаску
  Future.microtask(() => print('microtask'));

  //
  await Future<void>.delayed(Duration.zero).whenComplete(() => print('\n'));
  //

  //* await можно и обычные значения, в таком случае будет задержка в одну микротаску
  //; Если перед await будет значение/микротаска то event-loop прокрутит только микротаски!
  Future.microtask(() => print('microtask 1'));
  Future(() => print('future 1'));
  await null;
  Future.microtask(() => print('microtask 2'));

  //
  await Future<void>.delayed(Duration.zero).whenComplete(() => print('\n'));
  //

  //* Сравните с await Future.delayed(Duration.zero)
  Future.microtask(() => print('microtask 11'));
  Future(() => print('future 11'));
  await Future<void>.delayed(Duration.zero);
  Future.microtask(() => print('microtask 22'));
}

Future<void> testAsyncOrder1() async {
  Future<int> asyncFunction() async {
    return 42;
  }

  Future(() => print('Future 1'));
  Future.microtask(() => print('Microtask 1'));
  print(await asyncFunction());
  Future(() => print('Future 2'));
  Future.microtask(() => print('Microtask 2'));
}

Future<void> testAsyncOrder2() async {
  print('1');

  Future(() => print('2')).then((_) async {
    print('4');
    await Future(() => print('5'));
    print('6');
  });

  await Future.delayed(Duration.zero, () => print('7'));

  print('8');

  Future.microtask(() => print('9'));

  print('10');
}

Future<void> testAsyncOrder3() async {
  print('Start');

  scheduleMicrotask(() => print('Micro 1'));

  Future(() {
        print('Future 1');
        scheduleMicrotask(() => print('Micro 2'));
      })
      .then((_) async {
        print('Then 1');
        await Future(() => print('Future 2'));
        print('After await 1');
      })
      .then((_) {
        print('Then 2');
      });

  Future.delayed(Duration.zero, () => print('Delayed 1'));

  Future.microtask(() async {
    print('Microtask async 1');
    await Future<void>.delayed(Duration.zero);
    print('Microtask async 2');
  });

  print('End of main');
}

void main() {
  //defaultTimer();
  //timerRun();
  //periodicTimer();
  //pseudoFuture();
  //simpleFuture();
  //futureThen();
  //futureCatch();
  //futureIgnore();
  //futureWhenComplete();
  //simpleMicrotask();
  //callbackHell();
  //callbackHellFix();
  //asyncAwaitSimpleExample();
  //asyncAwaitSecondExample();
  //asyncCallbackHellFix();
  //unawaitedFutureError();
  //futureOr();
  //futureTypes();
  //additionalMoments();
  //testAsyncOrder1();
  //testAsyncOrder2();
  //testAsyncOrder3();
}
