import 'package:projeto_tutorial/dao/dao.dart';
import 'package:projeto_tutorial/model/comercio.dart';

abstract class DatabaseHelper {
  static late DatabaseHelper instance;

  Dao<Funcionario> get funcionarioDao;

  Future<void> iniciarDatabaseHelper();
}
