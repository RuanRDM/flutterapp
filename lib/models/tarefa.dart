class Tarefa {
  int id;
  String descricao;
  String obs;
  int concluida;
  Tarefa(this.id, this.descricao, this.obs, this.concluida);

  @override
  String toString() {
    return 'Tarefa(descricao: $descricao, obs: $obs, concluida: $concluida)';
  }
}