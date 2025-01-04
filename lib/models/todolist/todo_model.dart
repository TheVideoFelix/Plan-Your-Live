class TodoModel {
  final String id;
  final String title;
  final String? description;
  final String? toToDate;
  final bool isChecked;

  const TodoModel({
    required this.id,
    required this.title,
    this.description,
    this.toToDate,
    required this.isChecked,
  });
}
