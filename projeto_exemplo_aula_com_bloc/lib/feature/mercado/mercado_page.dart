import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_exemplo_aula_com_bloc/core/model/produto.dart';
import 'package:projeto_exemplo_aula_com_bloc/core/repositorio/mercado_repositorio_impl.dart';
import 'package:projeto_exemplo_aula_com_bloc/feature/mercado/bloc/mercado_bloc.dart';
import 'package:projeto_exemplo_aula_com_bloc/feature/mercado/popup_add_produto.dart';

class MercadoPage extends StatelessWidget {
  const MercadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MercadoBloc(MercadoRepositorioImpl()),
      child: const MercadoView(),
    );
  }
}

class MercadoView extends StatefulWidget {
  const MercadoView({super.key});

  @override
  createState() => _MercadoViewState();
}

class _MercadoViewState extends State<MercadoView> {
  // Lista dos produtos que serão exibidos
  late List<Produto> listaDeProdutos;

  // Criando uma referencia para acesso rapido ao bloc da pagina
  late final MercadoBloc bloc;

  @override
  void initState() {
    // Inicializando a lista de produtos
    listaDeProdutos = [];

    // Obtendo a referencia para o bloc da página
    bloc = BlocProvider.of<MercadoBloc>(context);

    // Inicializando o primeiro evento da página
    bloc.add(InicializacaoDaPaginaEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior da página
      appBar: AppBar(
        title: const Text('Segundo exemplo em flutter - BLOC'),
        backgroundColor: Colors.blue[100],
      ),
      // Conteúdo da página
      body: BlocListener<MercadoBloc, MercadoState>(
        listener: (context, state) {
          // Atualizando a lista de produtos de acordo com o estado
          if (state is PaginaCarregadaState) {
            setState(() {
              listaDeProdutos = state.listaAtualizada;
            });
          }
        },
        child: BlocBuilder<MercadoBloc, MercadoState>(
          builder: (context, state) {
            // Layout exibido quando a tela está carregando
            if (state is PaginaCarregandoState) {
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

            // Layout exibido quando o estado é válido
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
                    onPressed: () {
                      // Iniciando o evento de remoção do produto
                      bloc.add(RemoverProdutoEvent(produtoAtual, listaDeProdutos));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      // Botão flutuante fixo na página
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[200],
        onPressed: () {
          // Exibindo o PopUp ao clicar no botão flutuante
          showDialog(
            context: context,
            builder: (context) => PopupAddProduto(
              quandoAdicionarForPressionado: (produto) {
                // Iniciando o evento de adicionar produto
                bloc.add(AdicionarProdutoEvent(produto, listaDeProdutos));
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
