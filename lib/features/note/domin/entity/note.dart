import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

// class NoteEntity extends Equatable {
//   final String? id;
//   final String? title;
//   final String? content;
//   final DateTime? dateTime;
//   final Color? color;

//  const NoteEntity({this.id, this.title, this.content, this.dateTime, this.color});
//   @override
//   List<Object?> get props => [
//         id,
//         title,
//         content,
//         dateTime,
//         color,
//       ];
// }
@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? content;
  @HiveField(2)
  final DateTime? dateTime;
  @HiveField(3)
  final int? colorValue;

  Note({this.title, this.content, this.dateTime, this.colorValue});
}
