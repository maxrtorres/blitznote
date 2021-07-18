import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String body;
  @HiveField(2)
  String uuid = Uuid().v4();

  Note(this.title, this.body);

  @override
  bool operator ==(other) {
    if (other is! Note) {
      return false;
    }
    return uuid == (other as Note).uuid;
  }
}
