import 'package:projeto_exemplo_aula_com_bloc/core/model/produto.dart';

abstract class MercadoRepositorio {
  // Simula a obtenção dos produtos do banco de dados
  Future<List<Produto>> obtenhaTodosOsProdutos();
  // Simula o envio de um produto para o banco de dados
  Future<List<Produto>> enviarProdutoParaOBancoDeDados(Produto produto, List<Produto> listaDeProdutosAtual);
  // Simula a exclusão de um produto do banco de dados
  Future<List<Produto>> excluirProdutoDoBancoDeDados(Produto produto, List<Produto> listaDeProdutosAtual);
}
