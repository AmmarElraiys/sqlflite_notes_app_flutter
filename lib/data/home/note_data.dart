import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteAppDatabase {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'noteapp.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // USERS TABLE
    await db.execute(''' 
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        phone TEXT,
        password TEXT
      )
    ''');

    // NOTES GROUP TABLE
    await db.execute(''' 
      CREATE TABLE notesgroup (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userid INTEGER,
        groupname TEXT,
        FOREIGN KEY (userid) REFERENCES users(id)
      )
    ''');

    // NOTES TABLE
    await db.execute(''' 
  CREATE TABLE notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    contents TEXT,
    date TEXT,
    groupid INTEGER,
    FOREIGN KEY (groupid) REFERENCES notesgroup(id)
  )
''');
  }

  // Insert User
  Future<int> insertUser(Map<String, dynamic> user) async {
    final dbClient = await db;
    int resqopnse = await dbClient.insert('users', user);
    print(resqopnse);
    return resqopnse;
  }

  // Insert Notes Group
  Future<int> insertNotesGroup(Map<String, dynamic> group) async {
    final dbClient = await db;
    return await dbClient.insert('notesgroup', group);
  }

  // Insert Note
  Future<int> insertNote(Map<String, dynamic> note) async {
    final dbClient = await db;
    return await dbClient.insert('notes', note);
  }

  // Read Users
  Future<List<Map<String, dynamic>>> getUsers() async {
    final dbClient = await db;
    return await dbClient.query('users');
  }

  Future<List<Map<String, dynamic>>> getGroup() async {
    final dbClient = await db;
    return await dbClient.query('notesgroup');
  }

  // Read Notes Groups
  Future<List<Map<String, dynamic>>> getNotesGroups(int userId) async {
    final dbClient = await db;
    return await dbClient.query(
      'notesgroup',
      where: 'userid = ?',
      whereArgs: [userId],
    );
  }

  // Read Notes
  Future<List<Map<String, dynamic>>> getNotes(int groupId) async {
    final dbClient = await db;
    return await dbClient.query(
      'notes',
      where: 'groupid = ?',
      whereArgs: [groupId],
    );
  }

  // Update User
  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final dbClient = await db;
    return await dbClient.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update Notes Group
  Future<int> updateNotesGroup(int id, Map<String, dynamic> group) async {
    final dbClient = await db;
    return await dbClient.update(
      'notesgroup',
      group,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update Note
  Future<int> updateNote(int id, Map<String, dynamic> note) async {
    final dbClient = await db;
    return await dbClient.update(
      'notes',
      note,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete User
  Future<int> deleteUser(int id) async {
    final dbClient = await db;
    return await dbClient.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Delete Notes Group
  Future<int> deleteNotesGroup(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      'notesgroup',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete Note
  Future<int> deleteNote(int id) async {
    final dbClient = await db;
    return await dbClient.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Close the database
  Future close() async {
    final database = await db;
    database.close();
  }
}
