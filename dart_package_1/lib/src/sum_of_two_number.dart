void main() {}
int add({
  required int first,
  required int second,
  int? third,
  int? fourth,
}) {
  return first + second + (third ?? 0) + (fourth ?? 0);
}
