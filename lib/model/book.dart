import 'package:firebase_database/firebase_database.dart';
import 'package:googleapis/books/v1.dart';

class Book {
  final String id;
  final String title;
  final String description;
  final String thumb;

  Book(this.id, this.title, this.description, this.thumb);

  factory Book.fromVolume(Volume volume) {
    return new Book(
      volume.id,
      volume.volumeInfo.title,
      volume.volumeInfo.description,
      volume.volumeInfo.imageLinks.thumbnail,
    );
  }

  factory Book.fromSnapshot(DataSnapshot snapshot) {
    return new Book(
      snapshot.value['id'],
      snapshot.value['title'],
      snapshot.value['description'],
      snapshot.value['thumb'],
    );
  }
}
