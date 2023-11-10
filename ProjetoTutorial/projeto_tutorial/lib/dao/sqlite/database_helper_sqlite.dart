import 'package:flutter/cupertino.dart';
import 'package:projeto_tutorial/dao/dao.dart';
import 'package:projeto_tutorial/dao/database_helper.dart';
import 'package:projeto_tutorial/dao/sqlite/funcionario_dao_sqlite.dart';
import 'package:projeto_tutorial/model/comercio.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperSqlite extends DatabaseHelper {
  static DatabaseHelperSqlite? _instance;
  static DatabaseHelperSqlite get instance {
    _instance ??= DatabaseHelperSqlite._();
    return _instance!;
  }
  DatabaseHelperSqlite._();

  FuncionarioDaoSqlite? _funcionarioDao;

  @override
  Dao<Funcionario> get funcionarioDao {
    _funcionarioDao ??= FuncionarioDaoSqlite();
    return _funcionarioDao!;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      await iniciarDatabaseHelper();
    }
    if (_database == null) {
      throw Exception('Erro ao conectar com armazenamento de dados.');
    }
    return _database!;
  }

  @override
  Future<void> iniciarDatabaseHelper() async {
    WidgetsFlutterBinding.ensureInitialized();
    _database = await openDatabase(
      join(await getDatabasesPath(), 'comercio.db'),
      version: 1,
      onCreate: (db, version) => _criarBancoDeDados(db),
    );
  }

  static void _criarBancoDeDados(Database db) {
    db.execute('''
      CREATE TABLE Funcionario (
        codigo integer not null primary key autoincrement,
        nome text not null,
        cpf integer not null,
        endereco text not null,
        telefone text not null,
        email text not null,
        cargo text not null -- 'V': vendedor; 'C': comprador
      )''');
  }

}