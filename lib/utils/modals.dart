import 'dart:io';

class Student {
  String name;
  String grid;
  String course;
  File photo;

  Student({
    required this.name,
    required this.grid,
    required this.course,
    required this.photo,
  });

  factory Student.fromMap(Map<String, dynamic> data) {
    return Student(
      name: data['name'],
      grid: data['description'],
      course: data['image'],
      photo: data['image'],
    );
  }
}
