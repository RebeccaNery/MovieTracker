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

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'urlImagem': urlImagem,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
    };
  }

  factory Filme.fromMap(Map<String, dynamic> map){
    return Filme(
      id: map['id'],
      urlImagem: map['urlImagem'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['faixaEtaria'],
      duracao: map['duracao'],
      pontuacao: map['pontuacao'],
      descricao: map['descricao'],
      ano: map['ano'],
    );

  }

  @override
  String toString(){
    return "Filme(id: $id, urlImagem: $urlImagem, titulo: $titulo, genero: $genero, faixaEtaria: $faixaEtaria, duracao: $duracao, pontuacao: $pontuacao, descricao: $descricao, ano: $ano)";
  }
}