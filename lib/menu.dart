import 'package:flutter/material.dart';
import 'package:flutterapp/screens/form.dart';
import 'package:flutterapp/screens/list.dart';

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
          FormTarefa()
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.list_alt),
          label: "Tarefas"),
          BottomNavigationBarItem(icon: Icon(Icons.folder),
          label: "Form")
        ],
        onTap: (pagina){
          pc?.animateToPage(pagina, duration: Duration(microseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.grey[200],
      ),
    );
  }

}