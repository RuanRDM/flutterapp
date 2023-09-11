import 'package:flutter/material.dart';
import '../database/curso_dao.dart';
import '../models/curso.dart';
import 'formcursos.dart';

class ListaCurso extends StatefulWidget {
  List<Curso> _cursos = [];

  @override
  State<StatefulWidget> createState() {
    return ListaCursoState();
  }
}

class ListaCursoState extends State<ListaCurso> {
  CursoDao dao = CursoDao();

  @override
  Widget build(BuildContext context) {
    //   widget._cursos.add(Curso('preparar aula TDM', 'postar classroom'));
    //   widget._cursos.add(Curso('orientação TCC1', 'pelo meet'));
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Cursos"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final Future future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormCurso();
            }));
            future.then((curso) {
              setState(() {});
            });
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Curso>>(
            initialData: [],
            future: dao.findAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.data != null) {
                    final List<Curso>? cursos = snapshot.data;
                    return ListView.builder(
                        itemCount: cursos!.length,
                        itemBuilder: (context, indice) {
                          final curso = cursos[indice];
                          return ItemCurso(context, curso);
                        });
                  }
                default:
                  return Center(
                    child: Text("Carregando"),
                  );
              }
              return Center(child: Text("Nenhum Curso"));
            }));
  }

  Widget ItemCurso(BuildContext context, Curso _curso) {
    return GestureDetector(
        onTap: (){
          final Future future = Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return FormCurso(curso: _curso);
              }));
          future.then((value) => setState((){}));
        },
        child:    Card(
          child: ListTile(
            title: Text(_curso.nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Duração: ${_curso.horas} Horas"),
                Text("Descrição: ${_curso.descricao}"),
                Text("Autor: ${_curso.autor}"),
              ],
            ),
            leading: Icon(Icons.school_outlined),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                GestureDetector(
                  onTap: (){ _confirmarExclusao(context, _curso.id);},
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.remove_circle,
                          color : Colors.red)
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  void _confirmarExclusao(BuildContext context, int cursoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação de Exclusão"),
          content: Text("Tem certeza de que deseja excluir este curso?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Excluir"),
              onPressed: () {
                // Coloque aqui a lógica para excluir o curso
                _excluir(context, cursoId);
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  void _excluir(BuildContext context, int id){
    dao.delete(id).then((value) => setState((){}));
  }
}
