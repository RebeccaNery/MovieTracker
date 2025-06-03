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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'urlImagem': urlImagem,
  //     'titulo': titulo,
  //     'genero': genero,
  //     'faixaEtaria': faixaEtaria,
  //     'duracao': duracao,
  //     'pontuacao': pontuacao,
  //     'descricao': descricao,
  //     'ano': ano,
  //   };
  // }
  //
  // factory Filme.fromMap(Map<String, dynamic> map) {
  //   return Filme(
  //     id: map['id'],
  //     urlImagem: map['urlImagem'],
  //     titulo: map['titulo'],
  //     genero: map['genero'],
  //     faixaEtaria: map['faixaEtaria'],
  //     duracao: map['duracao'],
  //     pontuacao: map['pontuacao'],
  //     descricao: map['descricao'],
  //     ano: map['ano'],
  //   );
  // }

  // Dentro da classe Filme em model/filme.dart
  factory Filme.fromJson(Map<String, dynamic> json) {
    // 'json' é mais comum para API
    return Filme(
      // mockapi.io retorna 'id' como string.
      // Adapte o tipo da sua propriedade 'id' na classe Filme para String se for usar o id da API.
      // Ou tenha um campo separado como 'idApi' (String) e 'idLocal' (int).
      // Assumindo que 'id' na classe Filme agora é String para o ID da API:
      id: json['id'] as String?,
      // O ID da API é string
      urlImagem: json['urlImagem'] as String,
      titulo: json['titulo'] as String,
      genero: json['genero'] as String,
      faixaEtaria: json['faixaEtaria'] as String,
      duracao: json['duracao'] as String,
      pontuacao: (json['pontuacao'] as num).toDouble(),
      // Mais seguro
      descricao: json['descricao'] as String,
      ano: json['ano'] as String,
      // A API também retorna 'createdAt', você pode mapear se precisar:
      // createdAt: json['createdAt'] as String?,
    );
  }

  // --- MÉTODO toJson() CORRIGIDO PARA A API ---
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
      // O campo 'createdAt' também é gerado pela API, não o envie.
    };

    return mapData;
  }

  @override
  String toString() {
    return "Filme(id: $id, urlImagem: $urlImagem, titulo: $titulo, genero: $genero, faixaEtaria: $faixaEtaria, duracao: $duracao, pontuacao: $pontuacao, descricao: $descricao, ano: $ano)";
  }
}
