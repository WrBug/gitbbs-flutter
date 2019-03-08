import 'package:sqflite/sqflite.dart';

class TransactionInfo {
  String tableName;
  Map<String, dynamic> data;
  String where;
  List<dynamic> whereArgs;
  Type type;

  TransactionInfo(this.tableName, this.data, this.type,
      {this.where, this.whereArgs});

  Future<int> run(Transaction txn) {
    if (type == Type.insert) {
      return txn.insert(tableName, data);
    }
    if (type == Type.update) {
      return txn.update(tableName, data,where: where, whereArgs: whereArgs);
    }
    return txn.delete(tableName, where: where, whereArgs: whereArgs);
  }
}

enum Type { insert, update, delete }
