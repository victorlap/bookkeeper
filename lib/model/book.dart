import 'package:googleapis/books/v1.dart';

class Book {
  final String title;
  final String description;
  final String thumb;

  factory Book.fromVolume(Volume volume) {
    return new Book(
      volume.volumeInfo.title,
        volume.volumeInfo.description,
        volume.volumeInfo.imageLinks.thumbnail
    );
  }

  Book(this.title, this.description, this.thumb);


}