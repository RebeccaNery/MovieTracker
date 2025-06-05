# 🎬 MovieTracker

Um aplicativo Flutter para gerenciar seu catálogo pessoal de filmes. Com o MovieTracker, você pode adicionar, visualizar, editar e excluir filmes de forma simples e prática — tudo isso com uma interface amigável e moderna.

---

## 📱 Funcionalidades

- ✅ Cadastro de filmes com título, gênero, ano, nota e descrição.
- 🎞 Listagem de todos os filmes cadastrados
- ✏️ Edição e deleção de filmes
- ☁️ Armazenamento de dados e persistência através de uma API REST (mockapi.io).

---

## 🛠 Tecnologias Utilizadas

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- Gerenciamento de estado com `setState`
- Comunicação com API REST utilizando o pacote [`http`](https://pub.dev/packages/http).
- Backend Mock/API fornecido por [mockapi.io](https://mockapi.io/).

---

## 📸 Capturas de Tela

| Tela de Listagem | Tela de Cadastro |
|------------------|------------------|
| ![list](assets/screenshots/list.png) | ![form](assets/screenshots/form.png) |

---

## 🚀 Como Executar

1. **Clone o repositório:**

```bash
git clone https://github.com/RebeccaNery/movie_tracker.git
cd movie_tracker
```

2. **Instale as dependências:**

```bash
flutter pub get
```

3.  **Configurar a API (Importante):**
    Este projeto utiliza [mockapi.io](https://mockapi.io/) para simular um backend.

     **Configurando sua Própria API mockapi.io):**
    
    a. Crie uma conta em [mockapi.io](https://mockapi.io/).
      
    b. Crie um novo projeto.
    
    c. Dentro do projeto, crie um recurso (endpoint) chamado `filmes` (ou o nome que estiver no `FilmeApiConfig.url` após a base).
              
    d. Configure os campos (schema) para este recurso `filmes` para que correspondam ao modelo `Filme` no app (ex: `titulo` (string), `urlImagem` (string), `genero` (string), `faixaEtaria` (string), `duracao` (string), `pontuacao` (number), `descricao` (string), `ano` (string)). O mockapi.io adicionará automaticamente campos como `id` (string) e `createdAt` (datetime string).
    
    e. Abra o arquivo `lib/config/filme_api_config.dart` no projeto.
    
    f. Atualize a constante `url` com a URL base do seu endpoint no mockapi.io. Por exemplo:
               ```dart
               static const url = "https://SEU_ID_DE_PROJETO.mockapi.io/SEU_ENDPOINT_PRINCIPAL_SE_HOUVER/v1"; // E os métodos usarão /filmes
               ```

5. **Execute o app:**
```bash
flutter run
```
*(Lembre-se de que você precisará de conexão com a internet para que o app funcione, pois ele buscará os dados da API mockapi.io).*

## 📂 Estrutura do Projeto
```css
lib/
├── main.dart
├── config/         # Configurações, como a URL da API
│   └── filme_api_config.dart
├── controller/     # Controller (para API)
│   └── filme_api_controller.dart
├── model/          # Modelo de dados
│   └── filme.dart
├── view/           # Widgets de UI (Telas)
│   ├── listar_filmes.dart
│   ├── cadastrar_filme.dart
│   └── detalhar_filme.dart
└── theme.dart      # Definições de tema
```
## 🤝 Contribuição
Contribuições são bem-vindas! Sinta-se livre para abrir issues ou pull requests com melhorias, correções ou sugestões.

## 🧾 Licença
Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.



<h2 align="center">👩‍💻 Autora</h2>
<p align="center">
  <strong>Rebecca Nery</strong><br>
  <a href="https://www.linkedin.com/in/rebecca-nery">LinkedIn</a> • 
  <a href="https://github.com/RebeccaNery">GitHub</a>
</p>
