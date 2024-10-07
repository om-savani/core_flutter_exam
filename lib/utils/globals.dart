class Globals {
  static String? name, grid, course;
  static List<Map<String, dynamic>> students = [
    {'name': 'john doe', 'grid': '1234', 'course': 'Computer Science'},
  ];

  static void addStudent(String name, String grid, String course) {
    students.add({'name': name, 'grid': grid, 'course': course});
  }
}
