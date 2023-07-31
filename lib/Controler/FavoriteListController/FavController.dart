import 'package:library/Model/EBookModel/EBookModel.dart';
import 'package:library/Model/FavModle/FavotreModle.dart';
import 'package:library/Model/BookModle/BookModle.dart';
import 'package:library/Model/ProjectModel/CategoryProject.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

class FavController extends GetxController {
  var database;
  var selected = false.obs;
  var selectedbook = false.obs;
  int fi = 0;
  //List mapss = <Book>[];
  // late FavotreBook favotreBook;
  FavController() {
    //int id;

    initDb();
//check();
//
//  deleteFaveorte(id);
  }
  Project project = Project();
  EBook eBook = EBook();
  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'book_database.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE Faveorte(id INTEGER ,  name TEXT,type int)");
        // db.execute(
        //   "CREATE TABLE ebook(id INTEGER ,  name TEXT)",
        // );
        // db.execute(
        //   "CREATE TABLE project(id INTEGER ,  name TEXT)",
        // );

        return db;
      },
      version: 1,
    );

    getPeople().then((value) {});
    update();
  }

  Future<int> checkBoo(
    int id,
  ) async {
    final Database db = await database;

    fi = Sqflite.firstIntValue(
        await db.rawQuery('select COUNT(*) from Faveorte  where id = $id'))!;
    if (fi <= 0) {
      selectedbook.value = false;
      fi = 0;
      update();
      return fi;
    } else {
      selectedbook.value = true;
      print(fi);
      fi = 1;
      update();
      return fi;
    }
  }

  Future<bool> checkBook(int id, Book book) async {
    final Database db = await database;
    // String rawqi;
    //rawqi = db.rawQuery('select * from book , where: id = $id') as String;

    final fi = Sqflite.firstIntValue(
        await db.rawQuery('select COUNT(*) from Faveorte  where id = $id'));
    if (fi! == 0) {
      selected.value = false;
      print("yes existbook");
      await db.insert(
        'Faveorte',
        //  Book.fromJson(book);
        book.toMapFav(),

        // conflictAlgorithm: ConflictAlgorithm.replace,
      );

      update();
    } else {
      selected.value = true;
      print("Notfound book");
      await db.delete(
        'Faveorte',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      selected.value = false;
      update();
      selected.value = true;

      return false;
    }
    return selected.value;
  }

  Future<bool> checkEBook(int id, EBook ebook) async {
    final Database db = await database;
    // String rawqi;
    //rawqi = db.rawQuery('select * from book , where: id = $id') as String;

    final fi = Sqflite.firstIntValue(
        await db.rawQuery('select COUNT(*) from Faveorte  where id = $id'));
    if (fi! >= 1) {
      print("yes existbook");

      await db.delete(
        'Faveorte',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      selected.value = false;
      update();
    } else {
      print("Notfound book");
      await db.insert(
        'Faveorte',
        //  Book.fromJson(book);
        ebook.toMapFav(),

        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
      update();
      selected.value = true;

      return false;
    }
    return selected.value;
  }

  Future<bool> checkProjec(int id, Project project) async {
    final Database db = await database;

    final fi = Sqflite.firstIntValue(
        await db.rawQuery('select COUNT(*) from Faveorte  where id = $id'));
    if (fi! <= 0) {
      selected.value = true;
      return false;
    } else {
      selected.value = false;
      return true;
    }
  }

  Future insrtEbook(int id, EBook eBook) async {
    final Database db = await database;
    await db.insert(
      'Faveorte',
      //  Book.fromJson(book);
      eBook.toMapFav(),
    );
  }

  Future insrtProjec(int id, Project project) async {
    final Database db = await database;
    await db.insert(
      'Faveorte',
      //  Book.fromJson(book);
      project.toMapFav(),
    );
  }

  Future deletProjec(int id, Project project) async {
    final Database db = await database;
    await db.delete(
      'Faveorte',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<bool> checkProject(int id, Project project) async {
    final Database db = await database;

    final fi = Sqflite.firstIntValue(
        await db.rawQuery('select COUNT(*) from Faveorte  where id = $id'));
    if (fi! <= 0) {
      print("Notfound book");
      await db.insert(
        'Faveorte',
        //  Book.fromJson(book);
        project.toMapFav(),

        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
      update();
      selected.value = false;

      return false;
    } else {
      print("yes existbook");

      await db.delete(
        'Faveorte',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      selected.value = true;
      update();
    }
    return selected.value;
  }
// ////////

/////////

  Future<List> getPeople() async {
    // Get a reference to the database.
    final Database db = database;

    // Query the table for all The Dogs.
    List<Map> list = await db.query(
      'Faveorte',
    );

    //List<Book> bookt =
    //[]; //= maps.//map((Book) => Book.fromMap(Book).toList());
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return list
        .map((favotrebook) => FavotreBook.fromMapObject(favotrebook))
        .toList();
    // });
  }

  Future<void> deleteFaveorte(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      'Faveorte',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );

    selected.value = false;

    update();
    print("deletedproject");
  }

  Future insrt(int id, Book book) async {
    final Database db = await database;
    await db.insert(
      'Faveorte',
      //  Book.fromJson(book);
      book.toMapFav(),
    );

    selected.value = true;
    update();
  }

  Future delet(int id, Book book) async {
    final Database db = await database;
    await db.delete(
      'Faveorte',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    selected.value = false;
    update();
  }
}
