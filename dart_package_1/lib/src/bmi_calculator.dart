import 'dart:io';

void main() {
  print("Enter weight (in kilograms):");
  double weight = double.parse(stdin.readLineSync()!);

  print("Enter height (in meters):");
  double height = double.parse(stdin.readLineSync()!);

  double bmi = weight / (height * height);
  print("Your BMI is: ${bmi.toStringAsFixed(2)}");

  String weightStatus;

  if (bmi < 18.5) {
    weightStatus = "Underweight";
  } else if (bmi >= 18.5 && bmi <= 24.9) {
    weightStatus = "Normal weight";
  } else if (bmi >= 25.0 && bmi <= 29.9) {
    weightStatus = "Overweight";
  } else if (bmi >= 30.0 && bmi <= 34.9) {
    weightStatus = "Obesity class I";
  } else if (bmi >= 35.0 && bmi <= 39.9) {
    weightStatus = "Obesity class II";
  } else {
    weightStatus = "Obesity class III";
  }

  print("Weight status: $weightStatus");
}
