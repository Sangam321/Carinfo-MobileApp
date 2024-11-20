void main() {
  List<int> arr = [12, 2, 4, 5, 6];
  displayArr(arr);
}

void displayArr(List<int> arr) {
  for (int i = 0; i < arr.length; i++) {
    print(arr[i]);
  }
  for (int i in arr) {
    print(i);
  }
}
