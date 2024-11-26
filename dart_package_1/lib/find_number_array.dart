void main() {
  List<int> arr = [1, 2, 3, 4, 5];
  displayArr(arr);
  searchElement(arr, 3);
}

void searchElement(List<int> arr, int searchValue) {
  bool flag = false;
  for (int i in arr) {
    if (i == searchValue) {
      flag = true;
      break;
    }
  }
  if (flag) {
    print('Found');
  } else {
    print('Not Found');
  }
}

void displayArr(List<int> arr) {
  for (int i = 0; i < arr.length; i++) {
    print(arr[i]);
  }
  for (int i in arr) {
    print(i);
  }
}
