import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:gitbbs/model/GitIssue.dart';
import 'package:gitbbs/model/PagingData.dart';
import 'package:gitbbs/model/db/transaction_info.dart';
import 'package:gitbbs/network/github/model/GithubLabel.dart';
import 'package:gitbbs/network/github/model/GithubUser.dart';
import 'package:gitbbs/network/github/model/GithubV4Issue.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GitIssueDataBase {
  Database _dataBase;

  //定义表名
  final String tableName = "git_issue";
  static const String db_name = 'gitbbs.db';
  static const int db_version = 1;

  //定义字段名
  static const String column_id = "iId";
  static const String column_number = "number";
  static const String column_title = "title";
  static const String column_cursor = "cursor";
  static const String column_publishedAt = "publishedAt";
  static const String column_updatedAt = "updatedAt";
  static const String column_issue_id = "id";
  static const String column_closed = "closed";
  static const String column_closedAt = "closedAt";
  static const String column_locked = "locked";
  static const String column_author = "author";
  static const String column_comments = "comments";
  static const String column_labels = "labels";
  static const String column_hasMore = "hasMore";
  static const String column_is_author = 'isAuthor';
  static const String column_browse_date = 'browseDate';
  static const String column_url = "url";
  static const List<String> columns = [
    column_id,
    column_number,
    column_title,
    column_cursor,
    column_url,
    column_publishedAt,
    column_updatedAt,
    column_issue_id,
    column_closed,
    column_closedAt,
    column_locked,
    column_author,
    column_comments,
    column_hasMore,
    column_is_author,
    column_browse_date
  ];

  static GitIssueDataBase createInstance() {
    return GitIssueDataBase();
  }

  Future get db async {
    if (_dataBase != null) {
      return _dataBase;
    } else
      _dataBase = await initDb();
    return _dataBase;
  }

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, db_name);
    var dataBase = await openDatabase(path,
        version: db_version, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return dataBase;
  }

  FutureOr _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var version = oldVersion; version < newVersion; version++) {}
  }

  //新建数据库表
  FutureOr _onCreate(Database db, int version) async {
    await db.execute('''create table $tableName(
    $column_id integer primary key autoincrement,
    $column_title text not null,
    $column_number integer not null UNIQUE,
    $column_cursor text not null UNIQUE,
    $column_publishedAt text,
    $column_updatedAt text,
    $column_issue_id text,
    $column_url text,
    $column_closed integer,
    $column_closedAt text ,
    $column_locked integer ,
    $column_author text,
    $column_comments integer,
    $column_labels text,
    $column_hasMore integer,
    $column_is_author integer,
    $column_browse_date integer)
    ''');
    await db.execute('''
    CREATE UNIQUE INDEX cursor on $tableName ($column_cursor);
    ''');
    await db.execute('''
    CREATE UNIQUE INDEX issue_number on $tableName ($column_number);
    ''');
  }

  Future<bool> deleteByNumber(int number) async {
    Database database = await db;
    int result = await database
        .delete(tableName, where: '$column_number=?', whereArgs: [number]);
    return true;
  }

  Future<bool> deleteByIssueId(String id) async {
    Database database = await db;
    int result = await database
        .delete(tableName, where: '$column_issue_id=?', whereArgs: [id]);
    return true;
  }

  Future<PagingData<GitIssue>> getBrowseHistories(
      {int beforeTime, GitIssue beforeIssue, int size = 50}) async {
    Database database = await db;
    if (beforeTime == null) {
      if (beforeIssue == null) {
        beforeTime = DateTime.now().millisecondsSinceEpoch;
      } else {
        var map = await _findByNumber(beforeIssue.getNumber());
        beforeTime = map[column_browse_date];
      }
    }
    List<GitIssue> issues = List();
    try {
      var list = await database.query(tableName,
          orderBy: '$column_browse_date desc',
          where: '$column_browse_date < ?',
          whereArgs: [beforeTime],
          limit: size);
      for (var map in list) {
        var issue = _toGitIssue(map);
        if (issue != null) {
          issues.add(issue);
        }
      }
    } catch (e) {} finally {
      database.close();
    }
    return PagingData(issues.length >= size, issues);
  }

  Future<int> getTodayHistoryCount() async {
    Database database = await db;
    var now = DateTime.now();
    var time = DateTime(now.year, now.month, now.day);
    int zeroTime = time.millisecondsSinceEpoch;
    var map = await database.query(tableName,
        where: '$column_browse_date >= ?', whereArgs: [zeroTime]);
    return map.length;
  }

  Future<bool> updateBrowseDate(GitIssue gitIssue) async {
    if (gitIssue == null) {
      return false;
    }
    var time = DateTime.now().millisecondsSinceEpoch;
    Database database = await db;
    database.update(tableName, {column_browse_date: time},
        where: '$column_number=?', whereArgs: [gitIssue.getNumber()]);
    return true;
  }

  Future<bool> save(GitIssue gitIssue, {bool updateBrowseDate}) async {
    if (gitIssue == null) {
      return false;
    }
    Database database = await db;
    var map = _toMap(gitIssue);
    if (map == null) {
      return false;
    }
    if (updateBrowseDate) {
      var time = DateTime.now().millisecondsSinceEpoch;
      map[column_browse_date] = time;
    }
    Map<String, dynamic> query = await _findByNumber(map[column_number]);
    if (query != null) {
      Map<String, dynamic> m = Map.from(query);
      m.addAll(map);
      database.update(tableName, m,
          where: '$column_number=?', whereArgs: [gitIssue.getNumber()]);
    } else {
      database.insert(tableName, map);
    }
    return true;
  }

  Future<bool> saveAll(List<GitIssue> list) async {
    List<GitIssue> issues = List();
    if (list?.isNotEmpty == true) {
      issues.addAll(List.of(list));
    } else {
      return Future.value(true);
    }
    Database database = await db;
    try {
      List<TransactionInfo> infos = List();
      for (var issue in issues) {
        var map = _toMap(issue);
        if (map == null) {
          continue;
        }
        Map<String, dynamic> query = await _findByNumber(map[column_number]);
        if (query != null) {
          Map<String, dynamic> m = Map.from(query);
          m.addAll(map);
          infos.add(TransactionInfo(tableName, m, Type.update,
              where: '$column_number=?', whereArgs: [map[column_number]]));
        } else {
          infos.add(TransactionInfo(tableName, map, Type.insert));
        }
      }
      bool result = await database.transaction((txn) async {
        bool failed = false;
        for (var info in infos) {
          var value = await info.run(txn);
          if (!failed) {
            failed = value == null;
          }
        }
        return !failed;
      });
      database.close();
      return result;
    } catch (e) {
      print(e);
    } finally {
      database.close();
    }
    return false;
  }

  Future<PagingData<GitIssue>> getList(
      {int beforeNumber, int size = 50}) async {
    Database database = await db;
    List<GitIssue> issues = List();
    try {
      List<Map<String, dynamic>> list = await database.query(tableName,
          columns: columns,
          orderBy: '$column_number desc',
          where: beforeNumber == null ? null : '$column_number < ?',
          whereArgs: beforeNumber == null ? null : [beforeNumber],
          limit: size);
      for (var map in list) {
        var issue = _toGitIssue(map);
        if (issue != null) {
          issues.add(issue);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      database.close();
    }
    return PagingData(issues.length == size, issues);
  }

  Future<Map<String, dynamic>> _findByNumber(int number) async {
    Database database = await db;
    var query = await database
        .query(tableName, where: '$column_number=?', whereArgs: [number]);
    if (query?.isNotEmpty == true) {
      return query.first;
    }
    return null;
  }

  Map<String, dynamic> _toMap(GitIssue issue) {
    if (issue is GithubV4Issue) {
      Map<String, dynamic> map = Map();
      if (issue.title != null) {
        map[column_title] = issue.title;
      }
      if (issue.cursor != null) {
        map[column_cursor] = issue.cursor;
      }
      map[column_number] = issue.number;
      map[column_publishedAt] = issue.publishedAt;
      map[column_updatedAt] = issue.updatedAt;
      map[column_issue_id] = issue.id;
      map[column_closed] = issue?.closed == true ? 1 : 0;
      map[column_closedAt] = issue.closedAt;
      map[column_url] = issue.url;
      map[column_locked] = issue?.locked == true ? 1 : 0;
      map[column_author] = jsonEncode(issue.author);
      map[column_labels] = jsonEncode(issue.labels);
      map[column_comments] = issue.comments;
      map[column_hasMore] = issue?.hasMore == true ? 1 : 0;
      map[column_is_author] = issue?.isAuthor == true ? 1 : 0;
      return map;
    }
    return null;
  }

  GitIssue _toGitIssue(Map<String, dynamic> map) {
    GithubV4Issue issue = GithubV4Issue();
    issue.title = map[column_title];
    issue.number = map[column_number];
    issue.cursor = map[column_cursor];
    issue.publishedAt = map[column_publishedAt];
    issue.updatedAt = map[column_updatedAt];
    issue.id = map[column_issue_id];
    issue.url = map[column_url];
    issue.closed = map[column_closed] == 1;
    issue.closedAt = map[column_closedAt];
    issue.locked = map[column_locked] == 1;
    issue.isAuthor = map[column_is_author] == 1;
    issue.author = GithubV4User.fromJson(jsonDecode(map[column_author]));
    List<GithubLabel> list = List();
    if (map[column_labels] != null) {
      try {
        List<dynamic> labelMap = jsonDecode(map[column_labels]);
        if (labelMap.length == 0) {
          labelMap.forEach((map) {
            var label = GithubLabel.fromJson(map);
            list.add(label);
          });
        }
      } catch (e) {}
    }
    issue.labels = list;
    issue.comments = map[column_comments];
    issue.hasMore = map[column_hasMore] == 1;
    return issue;
  }
}
