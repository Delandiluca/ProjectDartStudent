import 'package:projeto_tutorial/dao/dao.dart';
import 'package:projeto_tutorial/dao/database_helper.dart';
import 'package:projeto_tutorial/dao/memory/funcionario_dao_memory.dart';
import 'package:projeto_tutorial/model/comercio.dart';

class DatabaseHelperMemory extends DatabaseHelper {

  FuncionarioDaoMemory? _funcionarioDaoMemory;

  @override
  Dao<Funcionario> get funcionarioDao {
    _funcionarioDaoMemory ??= FuncionarioDaoMemory();
    return _funcionarioDaoMemory!;
  }

  @override
  Future<void> iniciarDatabaseHelper() async {
  }

}