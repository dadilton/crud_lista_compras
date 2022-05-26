import 'package:crud_lista_compras/dao/compras_dao.dart';
import 'package:crud_lista_compras/model/itemCompra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'item_compra_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemCompra> _listaCompras = [];
  bool _loading = true;
  ItemCompraDao _itemCompraDao = ItemCompraDao();

  @override
  void initState() {
    _itemCompraDao.listaTudo().then((listaCompras) {
      setState(() {
        _listaCompras = listaCompras;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Compras")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _adicionaItem,
      ),
      body: _geraListaCompra(),
    );
  }

  Widget _geraListaCompra() {
    if (_listaCompras.isEmpty) {
      return Center(
        child:
            _loading ? CircularProgressIndicator() : Text("Tudo limpo, aqui!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: _geraCompraSlidable,
        itemCount: _listaCompras.length,
      );
    }
  }

  Widget _geraItemCompra(BuildContext context, int index) {
    final itemCompra = _listaCompras[index];
    return CheckboxListTile(
      value: itemCompra.estacomprado,
      title: Text(itemCompra.nomeproduto ?? ""),
      subtitle: Text(itemCompra.descricao ?? ""),
      onChanged: (isChecked) {
        setState(() {
          itemCompra.estacomprado = isChecked!;
        });
        _itemCompraDao.atualiza(itemCompra);
      },
    );
  }

  Widget _geraCompraSlidable(BuildContext context, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _geraItemCompra(context, index),
      actions: <Widget>[
        IconSlideAction(
            caption: "Editar",
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () {
              _adicionaItem(itemEditado: _listaCompras[index], index: index);
            }),
        IconSlideAction(
          caption: "Excluir",
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _deletaItem(itemDeletado: _listaCompras[index], index: index);
          },
        ),
      ],
    );
  }

  Future _adicionaItem({ItemCompra? itemEditado, int? index}) async {
    final itemCompra = await showDialog<ItemCompra>(
      context: context,
      builder: (context) {
        return ItemCompraDialog(
          itemCompra: itemEditado,
        );
      },
    );

    if (itemCompra != null) {
      setState(() {
        if (index == null) {
          _listaCompras.add(itemCompra);
          _itemCompraDao.insere(itemCompra);
        } else {
          _listaCompras[index] = itemCompra;
          _itemCompraDao.atualiza(itemCompra);
        }
      });
    }
  }

  void _deletaItem({required ItemCompra itemDeletado, required int index}) {
    setState(() {
      _listaCompras.removeAt(index);
    });

    _itemCompraDao.deleta(itemDeletado.id ?? 0);
  }
}
