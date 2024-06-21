import 'package:projeto_exemplo_aula_com_bloc/core/model/produto.dart';
import 'package:projeto_exemplo_aula_com_bloc/core/repositorio/mercado_repositorio.dart';

class MercadoRepositorioImpl extends MercadoRepositorio {
  @override
  Future<List<Produto>> obtenhaTodosOsProdutos() async {
    // Simula o tempo de espera até que a requisição seja finalizada
    await Future.delayed(const Duration(seconds: 1));

    // Mocka 3 produtos iniciais e os devolve
    return [
      Produto(nome: 'Arroz', preco: 30.99),
      Produto(nome: 'Feijão', preco: 16.99),
      Produto(nome: 'Macarrão', preco: 6.99),
    ];
  }

  @override
  Future<List<Produto>> enviarProdutoParaOBancoDeDados(Produto produto, List<Produto> listaDeProdutosAtual) async {
    // Simula o tempo de espera até que a requisição seja finalizada
    await Future.delayed(const Duration(seconds: 1));

    // Cria uma nova lista apartir da lista anterior (Apenas para simular a adição em uma coleção já existente)
    final novaLista = listaDeProdutosAtual;
    // Adiciona o novo item na lista
    novaLista.add(produto);

    // Devolve a nova lista atualizada
    return novaLista;
  }

  @override
  Future<List<Produto>> excluirProdutoDoBancoDeDados(Produto produto, List<Produto> listaDeProdutosAtual) async {
    // Simula o tempo de espera até que a requisição seja finalizada
    await Future.delayed(const Duration(seconds: 1));

    // Cria uma nova lista apartir da lista anterior (Apenas para simular a remoção em uma coleção já existente)
    final novaLista = listaDeProdutosAtual;
    // Remove o item da lista
    novaLista.remove(produto);

    // Devolve a nova lista atualizada
    return novaLista;
  }
}
