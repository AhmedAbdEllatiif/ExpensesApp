import 'package:expenses_app/models/transaction_model.dart';
import 'package:expenses_app/utils/database_utils.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseBuilder{
  Future<Database> database() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), DatabaseUtils.dataBaseName),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute("CREATE TABLE ${DatabaseUtils.transactionTable}(${DatabaseUtils.id} INTEGER PRIMARY KEY, ${DatabaseUtils.transactionTitle} TEXT, ${DatabaseUtils.transactionAmount} DOUBLE, ${DatabaseUtils.timeStamp} INTEGER)");
        return db;

      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 7,
    );
  }


  Future<int> insertTransaction(MyTransaction transaction) async {
    int taskId = -1;
    // Get a reference to the database.
    final Database db = await database();

    // Insert the Task into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      DatabaseUtils.transactionTable,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,//when a conflict happened what should do
    ).then((value) =>
    taskId = value
    );
    return taskId;
  }



  Future<List<MyTransaction>> getAllTransactions() async {
    // Get a reference to the database.
    final Database db = await database();

    // Query the table for all The todoo.
    final List<Map<String, dynamic>> maps = await db.query(DatabaseUtils.transactionTable);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return MyTransaction(
        id: maps[i][DatabaseUtils.id],
        title:maps[i][DatabaseUtils.transactionTitle],
        amount:maps[i][DatabaseUtils.transactionAmount],
        dateTime: DateTime.fromMillisecondsSinceEpoch(maps[i][DatabaseUtils.timeStamp]),
        dateTimeMM_stamp:maps[i][DatabaseUtils.timeStamp],
      );
    }).reversed.toList();
  }

}