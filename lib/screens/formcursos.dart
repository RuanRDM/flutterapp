import 'package:flutter/material.dart';
import '../models/curso.dart';
import '../components/editor.dart';
import '../database/curso_dao.dart';

class FormCurso extends StatefulWidget {
  final Curso? curso;
  FormCurso({this.curso});

  @override
  State<StatefulWidget> createState() {
    return FormCursoState();
  }
}

class FormCursoState extends State<FormCurso> {
  final TextEditingController _controladorCurso = TextEditingController();
  final TextEditingController _controladorHoras = TextEditingController();
  final TextEditingController _controladorDescricao = TextEditingController();
  final TextEditingController _controladorAutor = TextEditingController();
  int? _id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form de Cursos"),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Editor(_controladorCurso, "Curso", "Informe o nome do Curso",
                      Icons.assignment),
                  Editor(_controladorHoras, "Horas", "Informe as horas",
                      Icons.assignment),
                  Editor(_controladorDescricao, "Descricao", "Informe a descricao",
                      Icons.assignment),
                  Editor(_controladorAutor, "Autor", "Informe o autor",
                      Icons.assignment),
                  ElevatedButton(
                      onPressed: () {
                        criarCurso(context);
                      },
                      child: Text("Salvar"))
                ],
              ))),
    );
  }

  void criarCurso(BuildContext context) {
    CursoDao dao = CursoDao();
    if (_id != null){ // alteração
      final curso = Curso(_id!, _controladorCurso.text, _controladorHoras.text, _controladorDescricao.text, _controladorAutor.text);
      dao.update(curso).then((id) => Navigator.pop(context));
    }else{
      final curso = Curso(0,_controladorCurso.text, _controladorHoras.text, _controladorDescricao.text, _controladorAutor.text);
      dao.save(curso).then((id) {
        print("curso incluído: " + id.toString());
        Navigator.pop(context);
      });
    }
    SnackBar snackBar = SnackBar(content: Text("Curso atualizado!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    if (widget.curso != null){
      _id = widget.curso!.id;
      _controladorCurso.text = widget.curso!.nome;
      _controladorHoras.text = widget.curso!.horas;
      _controladorDescricao.text = widget.curso!.descricao;
      _controladorAutor.text = widget.curso!.autor;
    }
  }
}
