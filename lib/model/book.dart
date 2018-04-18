import 'package:firebase_database/firebase_database.dart';
import 'package:googleapis/books/v1.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String thumb;
  final String publisher;
  final String publishedAt;
  final String category;

  Book(this.id, this.title, this.author, this.description, this.thumb, this.publisher, this.publishedAt, this.category);

  factory Book.fromVolume(Volume volume) {
    return new Book(
      volume.id,
      volume.volumeInfo.title,
      volume.volumeInfo.authors.first,
      volume.volumeInfo.description,
      volume.volumeInfo.imageLinks.thumbnail.replaceAll(new RegExp('zoom=1'), 'zoom=10'),
      volume.volumeInfo.publisher,
      volume.volumeInfo.publishedDate,
      volume.volumeInfo.categories.join(', '),
    );
  }

  factory Book.fromSnapshot(DataSnapshot snapshot) {
    return new Book(
      snapshot.value['id'],
      snapshot.value['title'],
      snapshot.value['author'],
      snapshot.value['description'],
      snapshot.value['thumb'],
      snapshot.value['publisher'],
      snapshot.value['publishedAt'],
      snapshot.value['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'author': this.author,
      'description': this.description,
      'thumb': this.thumb,
      'publisher': this.publisher,
      'publishedAt': this.publishedAt,
      'category': this.category,
      'id': this.id
    };
  }
}
