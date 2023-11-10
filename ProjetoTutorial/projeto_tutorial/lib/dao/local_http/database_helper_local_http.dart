
import 'package:projeto_tutorial/dao/dao.dart';
import 'package:projeto_tutorial/dao/database_helper.dart';
import 'package:projeto_tutorial/dao/local_http/funcionario_dao_local_http.dart';
import 'package:projeto_tutorial/model/comercio.dart';

class DatabaseHelperLocalHttp extends DatabaseHelper {
  static DatabaseHelperLocalHttp? _instance;
  static DatabaseHelperLocalHttp get instance {
    _instance ??= DatabaseHelperLocalHttp._();
    return _instance!;
  }
  DatabaseHelperLocalHttp._();

  FuncionarioDaoLocalHttp? _funcionarioDao;

  @override
  Dao<Funcionario> get funcionarioDao {
    _funcionarioDao ??= FuncionarioDaoLocalHttp();
    return _funcionarioDao!;
  }

  @override
  Future<void> iniciarDatabaseHelper() async {}

}