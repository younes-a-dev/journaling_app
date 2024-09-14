// import 'package:flutter/material.dart';
// import 'package:trading_journal/features/note/domin/entity/note.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// part 'note_model.g.dart';

// @HiveType(typeId: 1)
// class NoteModel extends HiveObject {
//   // final String? id;
//   @HiveField(0)
//   final String? title;
//   @HiveField(1)
//   final String? content;
//   @HiveField(2)
//   final DateTime? dateTime;
//   @HiveField(3)
//   final Color? color;

//   NoteModel({
//     // this.id,
//     this.title,
//     this.content,
//     this.dateTime,
//     this.color,
//   });

//   factory NoteModel.fromJson(Map<String, dynamic> json) {
//     return NoteModel(
//       // id: json['id'],
//       title: json['title'],
//       content: json['content'],
//       dateTime: json['dateTime'],
//       color: json['color'],
//     );
//   }

//   factory NoteModel.fromEntity(NoteEntity note) {
//     return NoteModel(
//       // id: note.id,
//       title: note.title,
//       content: note.content,
//       dateTime: note.dateTime,
//       color: note.color,
//     );
//   }

//   NoteEntity toEntity() {
//     return NoteEntity(
//       // id: id,
//       title: title,
//       content: content,
//       dateTime: dateTime,
//       color: color,
//     );
//   }
// }
