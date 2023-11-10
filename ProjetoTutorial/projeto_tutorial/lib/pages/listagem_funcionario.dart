import 'package:flutter/material.dart';
import 'package:projeto_tutorial/dao/dao.dart';
import 'package:projeto_tutorial/dao/database_helper.dart';
import 'package:projeto_tutorial/model/comercio.dart';
import 'package:projeto_tutorial/pages/formulario_funcionario.dart';

class ListagemFuncionario extends StatefulWidget {
  const ListagemFuncionario({super.key});

  @override
  State<ListagemFuncionario> createState() => _ListagemFuncionarioState();
}

class _ListagemFuncionarioState extends State<ListagemFuncionario> {
  late Dao<Funcionario> funcionarioDao;
  late List<Funcionario> listaFuncionarios = [];

  @override
  void initState() {
    super.initState();
    funcionarioDao = DatabaseHelper.instance.funcionarioDao;
    carregarFuncionarios();
  }

  void carregarFuncionarios() async {
    var lista = await funcionarioDao.listarTodos();
    listaFuncionarios.clear();
    setState(() {
      listaFuncionarios.addAll(lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Funcionários')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => abrirFormularioFuncionario(null),
                child: const Text('Novo funcionário'),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            criarTabela(),
          ],
        ),
      ),
    );
  }

  Widget criarTabela() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Nome')),
          DataColumn(label: Text("Telefone")),
          DataColumn(label: Text("Cargo")),
        ],
        rows: listaFuncionarios
            .map(
              (func) => DataRow(
                cells: [
                  DataCell(Text(func.nome)),
                  DataCell(Text(func.telefone)),
                  DataCell(Text(func.cargo)),
                ],
                onLongPress: () => abrirFormularioFuncionario(func),
              ),
            )
            .toList(),
      ),
    );
  }

  void abrirFormularioFuncionario(Funcionario? funcionario) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioFuncionario(registro: funcionario),
      ),
    );
    if (result is bool && result) {
      carregarFuncionarios();
    }
  }
}
