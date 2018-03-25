import 'package:book_keeper/model/book.dart';
import 'package:firebase_database/firebase_database.dart';


class DatabaseManager {
  List<Book> favorites = new List();
  final reference = FirebaseDatabase.instance.reference().child('books');

  DatabaseManager() {
    reference.onChildAdded.listen(_onBookAdded);
  }

  void _onBookAdded(Event event) {
    favorites.add(new Book.fromSnapshot(event.snapshot));
  }

  void sendBook(Book book) {
    reference.child(book.id).set({
      'title': book.title,
      'description': book.description,
      'thumb': book.thumb,
      'id': book.id
    });
  }

  void deleteBook(Book book) {
    if (book.id != null) {
      reference.child(book.id).remove();
      favorites.removeWhere((b) => b.id == book.id);
    }
  }

  bool hasFavorite(String id) {
    return favorites.where((b) => b.id == id).isNotEmpty;
  }
}
