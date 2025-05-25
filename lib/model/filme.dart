class Filme{
  int? id;
  String urlImagem;
  String titulo;
  String genero;
  String faixaEtaria;
  String duracao;
  double pontuacao;
  String descricao;
  String ano;

  Filme({this.id, required this.urlImagem, required this.titulo, required this.genero, required this.faixaEtaria, required this.duracao, required this.pontuacao, required this.descricao, required this.ano});

  @override
  String toString(){
    return "Filme(id: $id, urlImagem: $urlImagem, titulo: $titulo, genero: $genero, faixaEtaria: $faixaEtaria, duracao: $duracao, pontuacao: $pontuacao, descricao: $descricao, ano: $ano)";
  }
}