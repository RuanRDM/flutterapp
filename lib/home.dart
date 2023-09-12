import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:flutterapp/screens/form.dart';
import 'package:flutterapp/screens/formcursos.dart';
import 'package:flutterapp/screens/list.dart';
import 'package:flutterapp/screens/listcursos.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Função para navegar para a página MenuOptions
  void _navigateToMenuOptions() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MenuOptions(),
      ),
    );
  }

  // Função para navegar para a página ListaTarefa
  void _navigateToListaTarefa() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListaTarefa(),
      ),
    );
  }

  // Função para navegar para a página ListaCurso
  void _navigateToListaCurso() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListaCurso(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.assignment), // Ícone para ListaTarefa
            onPressed: _navigateToListaTarefa, // Navegar para ListaTarefa
          ),
          IconButton(
            icon: Icon(Icons.school), // Ícone para ListaCurso
            onPressed: _navigateToListaCurso, // Navegar para ListaCurso
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.0), // Espaçamento entre o texto e o botão
            ElevatedButton(
              onPressed: _navigateToMenuOptions,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60), // Tamanho mínimo do botão
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu_rounded), // Ícone do menu
                  SizedBox(width: 10.0), // Espaçamento entre o ícone e o texto
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24.0, // Tamanho do texto do botão
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}