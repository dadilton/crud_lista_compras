import 'package:crud_lista_compras/model/itemCompra.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemCompraDao {
  //a variável abaixo foi criada para criar apenas uma instância
  //desta classe.
  static final ItemCompraDao _instancia = ItemCompraDao._internal();

  //método criado com a palavra chave "factory"
  //serve para criar um construtor de classe que nem sempre
  //retorna uma nova instância de objeto da classe
  factory ItemCompraDao() {
    return _instancia;
  }

  ItemCompraDao._internal();

  //variável que contém um objeto do tipo Database, que é usado para
  //usar uma base de dados SQLite
  Database? _db;

  Future<Database> get db async {
    return _db ?? await iniciarBanco();
  }

  Future<Database> iniciarBanco() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "lista_compra.db");
    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE item_compra( "
          "id integer primary key, "
          "nomeproduto text, "
          "descricao text, "
          "preco real, "
          "estacomprado integer)");
    });
  }

  Future<ItemCompra> insere(ItemCompra item) async {
    Database database = await db;
    item.id = await database.insert('item_compra', item.toMap());
    return item;
  }

  Future<int> atualiza(ItemCompra item) async {
    Database database = await db;
    return await database.update(
      'item_compra',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleta(int id) async {
    Database database = await db;
    return await database.delete(
      "item_compra",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<ItemCompra>> listaTudo() async {
    Database database = await db;
    List listaDeMaps = await database.rawQuery("select * from item_compra");
    List<ItemCompra> listaDeCompras =
        listaDeMaps.map((map) => ItemCompra.fromMap(map)).toList();

    return listaDeCompras;
  }

  Future<ItemCompra> itemPorId(int id) async {
    Database database = await db;
    List<Map<String, dynamic>> listaCompras =
        await database.query("item_compra",
            columns: [
              'id',
              'nomeproduto',
              'descricao',
              'preco',
              'estacomprado',
            ],
            where: 'id = ?',
            whereArgs: [id]);

    if (listaCompras.isNotEmpty) {
      return ItemCompra.fromMap(listaCompras.first);
    } else {
      throw Exception("Compra não encontrada");
    }
  }
}
