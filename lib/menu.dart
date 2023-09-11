import 'package:flutter/material.dart';
import 'package:flutterapp/screens/form.dart';
import 'package:flutterapp/screens/formcursos.dart';
import 'package:flutterapp/screens/list.dart';
import 'package:flutterapp/screens/listcursos.dart';

class MenuOptions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MenuOptionsState();
  }
}

class MenuOptionsState extends State<MenuOptions>{
  int paginaAtual = 0;
  PageController? pc;

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  void initState() {
    super.initState();
    pc=PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : PageView(
        controller: pc,
        children: [
          ListaTarefa(),
          FormTarefa(),
          ListaCurso(),
          FormCurso()
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Tarefas',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Form Tarefas',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Cursos',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Form Cursos',
            backgroundColor: Colors.pink,
          ),
        ],
        onTap: (pagina){
          pc?.animateToPage(pagina, duration: Duration(microseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.grey[200],
      ),
    );
  }


}