import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projeto_exemplo_aula_com_bloc/core/model/produto.dart';
import 'package:projeto_exemplo_aula_com_bloc/core/repositorio/mercado_repositorio_impl.dart';

part 'mercado_event.dart';
part 'mercado_state.dart';

class MercadoBloc extends Bloc<MercadoEvent, MercadoState> {
  final MercadoRepositorioImpl _mercadoRepositorio;

  MercadoBloc(this._mercadoRepositorio) : super(MercadoInitial()) {
    on<InicializacaoDaPaginaEvent>(_buscarListaDeProdutosAtual);
    on<AdicionarProdutoEvent>(_adicionarProdutoAoBancoDeDados);
    on<RemoverProdutoEvent>(_removerProdutoDoBancoDeDados);
  }

  void _buscarListaDeProdutosAtual(InicializacaoDaPaginaEvent event, Emitter emit) async {
    // Emite o estado de carregando, isso faz com que a tela exiba o loading
    emit(PaginaCarregandoState());

    // Obtem do repositorio os produtos atuais
    final resultadoDaBusca = await _mercadoRepositorio.obtenhaTodosOsProdutos();

    // Emite o estado de tela carregada passando a lista atualizada
    emit(PaginaCarregadaState(resultadoDaBusca));
  }

  void _adicionarProdutoAoBancoDeDados(AdicionarProdutoEvent event, Emitter emit) async {
    // Emite o estado de carregando, isso faz com que a tela exiba o loading
    emit(PaginaCarregandoState());

    // Envia para o repositorio o produto que deve ser adicionado
    final resultadoDaBusca = await _mercadoRepositorio.enviarProdutoParaOBancoDeDados(
      event.produtoParaAdicionar,
      event.listaDeProdutosAtual,
    );

    // Emite o estado de tela carregada passando a lista atualizada conforme a adição
    emit(PaginaCarregadaState(resultadoDaBusca));
  }

  void _removerProdutoDoBancoDeDados(RemoverProdutoEvent event, Emitter emit) async {
    // Emite o estado de carregando, isso faz com que a tela exiba o loading
    emit(PaginaCarregandoState());

    // Envia para o repositorio o produto que deve ser removido
    final resultadoDaBusca = await _mercadoRepositorio.excluirProdutoDoBancoDeDados(
      event.produtoParaRemover,
      event.listaDeProdutosAtual,
    );

    // Emite o estado de tela carregada passando a lista atualizada conforme a remoção
    emit(PaginaCarregadaState(resultadoDaBusca));
  }
}
