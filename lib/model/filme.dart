class Filme {
  int? id;
  String urlImagem;
  String titulo;
  String genero;
  String faixaEtaria;
  String duracao;
  double pontuacao;
  String descricao;
  String ano;

  Filme({
    this.id,
    required this.urlImagem,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.descricao,
    required this.ano,
  });

  factory Filme.fromJson(Map<String, dynamic> json) {
    String? idDaApiString = json['id'] as String?;
    return Filme(
      id: (idDaApiString == null) ? null : int.tryParse(idDaApiString),
      // O ID da API é string
      urlImagem: json['urlImagem'] as String,
      titulo: json['titulo'] as String,
      genero: json['genero'] as String,
      faixaEtaria: json['faixaEtaria'] as String,
      duracao: json['duracao'] as String,
      pontuacao: (json['pontuacao'] as num).toDouble(),
      descricao: json['descricao'] as String,
      ano: json['ano'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final mapData = <String, dynamic>{
      'titulo': titulo,
      'urlImagem': urlImagem,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
      // O campo 'createdAt' também é gerado pela API, não enviar.
    };

    return mapData;
  }

  @override
  String toString() {
    return "Filme(id: $id, urlImagem: $urlImagem, titulo: $titulo, genero: $genero, faixaEtaria: $faixaEtaria, duracao: $duracao, pontuacao: $pontuacao, descricao: $descricao, ano: $ano)";
  }
}
