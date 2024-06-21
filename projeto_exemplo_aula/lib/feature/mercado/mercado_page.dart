import 'package:flutter/material.dart';
import 'package:projeto_exemplo_aula/core/model/produto.dart';
import 'package:projeto_exemplo_aula/feature/mercado/popup_add_produto.dart';

class MercadoPage extends StatefulWidget {
  const MercadoPage({super.key});

  @override
  createState() => _MercadoPageState();
}

class _MercadoPageState extends State<MercadoPage> {
  // Lista dos produtos que serão exibidos
  late List<Produto> listaDeProdutos;

  // Controlador para informar se a tela está carregando ou não
  bool estaCarregando = false;

  @override
  void initState() {
    // Inicializando a lista de produtos
    listaDeProdutos = [
      Produto(nome: 'Arroz', preco: 30.99),
      Produto(nome: 'Feijão', preco: 16.99),
      Produto(nome: 'Macarrão', preco: 6.99),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior da página
      appBar: AppBar(
        title: const Text('Primeiro exemplo em flutter'),
        backgroundColor: Colors.blue[100],
      ),
      // Conteúdo da página
      body: Builder(
        builder: (context) {
          // Layout exibido quando a tela está carregando
          if (estaCarregando) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue[200],
              ),
            );
          }

          // Layout exibido quando a lista de produtos está vazia
          if (listaDeProdutos.isEmpty) {
            return const Center(
              child: Text(
                'Você ainda não possui produtos cadastrados.',
              ),
            );
          }

          // Layout exibido quando existe algum produto na lista
          return ListView.builder(
            itemCount: listaDeProdutos.length,
            itemBuilder: (context, index) {
              // Obtem o item atual da lista
              final produtoAtual = listaDeProdutos[index];

              // Cria o item visual usando os dados do item atual da lista
              return ListTile(
                title: Text(produtoAtual.nome),
                subtitle: Text("R\$ ${produtoAtual.preco}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    //Inicia o carregamento da tela
                    setState(() {
                      estaCarregando = true;
                    });

                    // Simula a remoção do produto no banco de dados
                    final resultadoDaExclusao = await _excluirProdutoDoBancoDeDados(produtoAtual);

                    // Atualiza a nova lista e finaliza o carregamento da tela
                    setState(() {
                      listaDeProdutos = resultadoDaExclusao;
                      estaCarregando = false;
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      // Botão flutuante fixo na página
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[200],
        onPressed: () {
          // Exibindo o PopUp ao clicar no botão flutuante
          showDialog(
            context: context,
            builder: (context) => PopupAddProduto(
              quandoAdicionarForPressionado: (produto) async {
                // Atualiza o estado da pagina para carregando.
                setState(() {
                  estaCarregando = true;
                });

                // Simulando a ida no banco de dados
                final resultadoDoEnvio = await _enviarProdutoParaOBancoDeDados(produto);

                // Atualiza o estado da página e a lista de produtos
                setState(() {
                  listaDeProdutos = resultadoDoEnvio;
                  estaCarregando = false;
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Produto>> _enviarProdutoParaOBancoDeDados(Produto produto) async {
    // SImula o tempo de espera até que a requisição seja finalizada
    await Future.delayed(const Duration(seconds: 1));

    final novaLista = listaDeProdutos;
    novaLista.add(produto);

    return novaLista;
  }

  Future<List<Produto>> _excluirProdutoDoBancoDeDados(Produto produto) async {
    // SImula o tempo de espera até que a requisição seja finalizada
    await Future.delayed(const Duration(seconds: 1));

    final novaLista = listaDeProdutos;
    novaLista.remove(produto);

    return novaLista;
  }
}
