class Person {
  String fname;
  String lname;
  int age;
  String address;

  Person(this.fname, this.lname, this.age, this.address);

  Person copyWith({String? fname, String? lname, int? age, String? address}) {
    return Person(
      fname ?? this.fname,
      lname ?? this.lname,
      age ?? this.age,
      address ?? this.address,
    );
  }
}
