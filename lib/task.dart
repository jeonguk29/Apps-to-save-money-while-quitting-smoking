import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late bool completed;


  Task(this.title, this.completed);
}