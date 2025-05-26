
import '../model/filme.dart';

class FilmeService{
  static final _filmes = [
    Filme(
      id: 1,
      titulo: 'A Origem',
      urlImagem: 'https://upload.wikimedia.org/wikipedia/pt/8/84/AOrigemPoster.jpg',
      genero: 'Ficção Científica',
      faixaEtaria: '12 anos',
      duracao: '2h 28min',
      pontuacao: 9,
      descricao: 'Um ladrão que rouba segredos corporativos por meio da tecnologia de compartilhamento de sonhos é encarregado de plantar uma ideia na mente de um C.E.O.',
      ano: '2010',
    ),
    Filme(
      id: 2,
      titulo: 'Interestelar',
      urlImagem: 'https://m.media-amazon.com/images/M/MV5BMmUwMmFlMzktYWVlNy00N2I0LWFhMTYtZWI2ZTM4N2I3ZTk0XkEyXkFqcGc@._V1_.jpg',
      genero: 'Ficção Científica',
      faixaEtaria: '10 anos',
      duracao: '2h 49min',
      pontuacao: 8,
      descricao: 'Uma equipe de exploradores viaja através de um buraco de minhoca no espaço na tentativa de garantir a sobrevivência da humanidade.',
      ano: '2014',
    ),
    Filme(
      id: 3,
      titulo: 'Clube da Luta',
      urlImagem: 'https://br.web.img3.acsta.net/medias/nmedia/18/90/95/96/20122166.jpg',
      genero: 'Drama',
      faixaEtaria: '18 anos',
      duracao: '2h 19min',
      pontuacao: 3,
      descricao: 'Um homem insatisfeito com a vida e com seu trabalho encontra um novo sentido ao participar de um clube de luta underground.',
      ano: '1999',
    )
  ];

  List<Filme> get filmes{
    return List.unmodifiable(_filmes);
  }

  void adicionar(Filme filme){
    _filmes.add(filme);
  }
}