class Curso {
  int id;
  String nome;
  String horas;
  String descricao;
  String autor;
  Curso(this.id, this.nome, this.horas, this.descricao, this.autor);

  @override
  String toString() {
    return 'Curso(nome: $nome, horas: $horas, descricao: $descricao, autor: $autor)';
  }
}