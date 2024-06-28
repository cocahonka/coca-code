import 'dart:math';

void hello() => print('hello world');

bool isPrime(int number) {
  if (number <= 1) return false;

  for (var i = 2; i <= sqrt(number).toInt(); i++) {
    if (number % i == 0) return false;
  }

  return true;
}
