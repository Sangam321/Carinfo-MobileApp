import 'dart:io';

void main() {
  print("Enter Principal amount:");
  double principal = double.parse(stdin.readLineSync()!);

  print("Enter Rate of Interest:");
  double rate = double.parse(stdin.readLineSync()!);

  print("Enter Time (in years):");
  double time = double.parse(stdin.readLineSync()!);

  double simpleInterest = (principal * rate * time) / 100;

  print("The Simple Interest is: \$${simpleInterest.toStringAsFixed(2)}");
}
