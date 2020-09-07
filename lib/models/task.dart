class Task {
  final String name;
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Task.fromJson(Map<String, dynamic> json)
      : name = json['item'],
        isDone = json['done'];

  Map<String, dynamic> toJson() => {'item': name, 'done': isDone};
}
