import 'package:get_it/get_it.dart';
import 'package:my_tasks/src/data/dao.dart';

import 'data/database.dart';

Future<void> setupDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dao = database.dao;
  GetIt.I.registerSingleton<Dao>(dao);
}