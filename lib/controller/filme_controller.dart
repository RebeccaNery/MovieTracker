import '../model/filme.dart';
import '../service/filme_service.dart';

class FilmeController {
  final _service = FilmeService();

  Future<List<Filme>?> findAll() async {
    return await _service.findAll();
  }

  Future<int?> save(
    String titulo,
    String urlImagem,
    String genero,
    String faixaEtaria,
    String duracao,
    double pontuacao,
    String descricao,
    String email,
  ) async {
    return await _service.save(
      Filme(
        titulo: titulo,
        urlImagem: urlImagem,
        genero: genero,
        faixaEtaria: faixaEtaria,
        duracao: duracao,
        pontuacao: pontuacao,
        descricao: descricao,
        ano: email,
      ),
    );
  }
}
