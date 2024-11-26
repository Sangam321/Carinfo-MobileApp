class Person {
  String fname;
  String lname;
  int age;
  String address;

  Person(
      {required this.fname,
      required this.lname,
      required this.age,
      required this.address});

  Person copyWith({String? fname, String? lname, int? age, String? address}) {
    return Person(
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      age: age ?? this.age,
      address: address ?? this.address,
    );
  }
}
