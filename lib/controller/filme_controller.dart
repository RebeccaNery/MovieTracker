import '../model/filme.dart';
import '../service/filme_service.dart';

class FilmeController{

  final _service = FilmeService();

  List<Filme> getFilmes(){
    return _service.filmes;
  }

  void adicionar(String titulo, String urlImagem, String genero, String faixaEtaria, String duracao, double pontuacao, String descricao, String email){
    _service.adicionar(Filme(titulo: titulo, urlImagem: urlImagem, genero: genero, faixaEtaria: faixaEtaria, duracao: duracao, pontuacao: pontuacao, descricao: descricao, ano: email));
  }
}