void main() {
  List<int> arr = [1, 2, 3, 4];
  displayArr(arr);
}

void countEvenOdd(List<int> arr) {
  int countEven = 0;
  int countOdd = 0;
  for (int i in arr) {
    if (i % 2 == 0) {
      countEven++;
    } else {
      countOdd++;
    }
  }
  print("Even: $countEven and odd: $countOdd");
}

void displayArr(List<int> arr) {
  for (int i = 0; i < arr.length; i++) {
    print(arr[i]);
  }
  for (int i in arr) {
    print(i);
  }
}
