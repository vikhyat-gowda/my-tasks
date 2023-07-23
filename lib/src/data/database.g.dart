// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Dao? _daoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Task` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT, `startDate` INTEGER NOT NULL, `endDate` INTEGER, `reopenDate` INTEGER, `isOpen` INTEGER, `isFollowUp` INTEGER, `followUpId` INTEGER, `priority` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  Dao get dao {
    return _daoInstance ??= _$Dao(database, changeListener);
  }
}

class _$Dao extends Dao {
  _$Dao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Task',
            (Task item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'reopenDate': item.reopenDate,
                  'isOpen': item.isOpen == null ? null : (item.isOpen! ? 1 : 0),
                  'isFollowUp': item.isFollowUp == null
                      ? null
                      : (item.isFollowUp! ? 1 : 0),
                  'followUpId': item.followUpId,
                  'priority': item.priority
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  @override
  Future<List<Task>> getAllTask() async {
    return _queryAdapter.queryList('Select * FROM Task',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String?,
            startDate: row['startDate'] as int,
            endDate: row['endDate'] as int?,
            reopenDate: row['reopenDate'] as int?,
            isOpen: row['isOpen'] == null ? null : (row['isOpen'] as int) != 0,
            isFollowUp: row['isFollowUp'] == null
                ? null
                : (row['isFollowUp'] as int) != 0,
            followUpId: row['followUpId'] as int?,
            priority: row['priority'] as int));
  }

  @override
  Stream<List<Task?>> getRelevantTaskForToday(int currDate) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Task WHERE date(datetime(startDate, \"unixepoch\")) <= date(datetime(?1, \"unixepoch\")) AND (endDate IS NULL OR date(datetime(endDate, \"unixepoch\")) = date(datetime(?1, \"unixepoch\")))',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String?,
            startDate: row['startDate'] as int,
            endDate: row['endDate'] as int?,
            reopenDate: row['reopenDate'] as int?,
            isOpen: row['isOpen'] == null ? null : (row['isOpen'] as int) != 0,
            isFollowUp: row['isFollowUp'] == null
                ? null
                : (row['isFollowUp'] as int) != 0,
            followUpId: row['followUpId'] as int?,
            priority: row['priority'] as int),
        arguments: [currDate],
        queryableName: 'Task',
        isView: false);
  }

  @override
  Stream<Task?> getTaskById(int id) {
    return _queryAdapter.queryStream('Select * From Task WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String?,
            startDate: row['startDate'] as int,
            endDate: row['endDate'] as int?,
            reopenDate: row['reopenDate'] as int?,
            isOpen: row['isOpen'] == null ? null : (row['isOpen'] as int) != 0,
            isFollowUp: row['isFollowUp'] == null
                ? null
                : (row['isFollowUp'] as int) != 0,
            followUpId: row['followUpId'] as int?,
            priority: row['priority'] as int),
        arguments: [id],
        queryableName: 'Task',
        isView: false);
  }

  @override
  Future<void> insertTask(Task task) async {
    await _taskInsertionAdapter.insert(task, OnConflictStrategy.abort);
  }
}
