// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_new, curly_braces_in_flow_control_structures, unused_local_variable, avoid_print, use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, unused_field, prefer_final_fields, unused_import, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CoinApp());
}

class CoinApp extends StatelessWidget {
  const CoinApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Crypto Coin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Crypto Coin',
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Criar Moeda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateCoinRoute(title: 'Teste')),
                );
              },
            ),
            ListTile(
              title: const Text('Lista de Moedas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateListCoinRoute()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(
                    'Bem-vindo ao Crypto Coin, navegue por essa experiência e crie suas próprias criptomoedas!',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text('Você pode criar a moeda com o nome e a imagem que quiser!'),
                ),
              ),
               Card(
                child: ListTile(
                  title: Text(
                    'O que é criptomoeda?',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text('Criptomoeda é o nome genérico para moedas digitais descentralizadas, criadas em uma rede blockchain a partir de sistemas avançados de criptografia que protegem as transações, suas informações e os dados de quem transaciona. '),
                ),
              ),
               Card(
                child: ListTile(
                  title: Text(
                    'Para que servem as criptomoedas? ',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text('Assim como toda moeda, como dólar e o real, as criptomoedas servem para comprar serviços e produtos online. Contudo, não é essa a principal função que as criptos ganharam ao longo do tempo. Por causa das tecnologias que muitas delas carregam, elas foram vistas como oportunidade de reserva financeira de longo prazo por muita gente. Veja as principais funções das criptos. '),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> submitData(String name, String symbol, String price,
    String marketCap, String image) async {
  var priceDouble = double.parse(price);
  var marketCapDouble = double.parse(marketCap);

  var headers = {'Content-Type': 'application/json'};
  var request =
      http.Request('POST', Uri.parse('https://localhost:7014/api/Crypto'));
  request.body = json.encode({
    "name": name,
    "symbol": symbol,
    "current_Price": priceDouble,
    "market_Cap": marketCapDouble,
    "imageLink": image
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 201 || response.statusCode == 200) {
    var data = await response.stream.bytesToString();
    return true;
  } else {
    return false;
  }
}

class CreateCoinRoute extends StatefulWidget {
  const CreateCoinRoute({super.key, required this.title});

  final String title;

  @override
  State<CreateCoinRoute> createState() => _CreateCoinRoute();
}

class _CreateCoinRoute extends State<CreateCoinRoute> {
  TextEditingController nameController = TextEditingController();
  TextEditingController symbolController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController marketcapController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua propria criptomoeda'),
      ),
      body: (Center(
        child: Container(
          margin: new EdgeInsets.symmetric(vertical: 20.0),
          child: Column(children: [
            Text(
              'Formulario de Cadastro',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome da Moeda',
              ),
              controller: nameController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Apelido',
              ),
              controller: symbolController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Preço da Moeda',
              ),
              controller: priceController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Capitalização de Mercado',
              ),
              controller: marketcapController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Link da Imagem',
              ),
              controller: imageController,
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String symbol = symbolController.text;
                  String price = priceController.text;
                  String marketCap = marketcapController.text;
                  String image = imageController.text;

                  bool data =
                      await submitData(name, symbol, price, marketCap, image);

                  if (data == true) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateListCoinRoute()),
                    );
                  }
                },
                child: Text("Cadastrar"))
          ]),
        ),
      )),
    );
  }
}

class CreateListCoinRoute extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController symbolController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController marketcapController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  Future<bool> updateCoin(String name, String symbol, String price,
      String marketCap, String image, String id) async {
    var headers = {'Content-Type': 'application/json'};

    var priceDouble = double.parse(price);
    var marketCapDouble = double.parse(marketCap);

    var request = http.Request(
        'PUT', Uri.parse('https://localhost:7014/api/Crypto?id=' + id));
    request.body = json.encode({
      "id": id,
      "name": name,
      "symbol": symbol,
      "current_Price": priceDouble,
      "market_Cap": marketCapDouble,
      "imageLink": image
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<List> getCoins() async {
    var response = await http.get(
        Uri.parse("https://localhost:7014/api/Crypto"),
        headers: {"Accept": "application/json"});

    return jsonDecode(response.body);
  }

  Future<bool> deleteCoin(id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.MultipartRequest('DELETE',
        Uri.parse('https://localhost:7014/api/Crypto?id=' + id.toString()));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Moedas'),
      ),
      body: FutureBuilder<List>(
        future: getCoins(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados do servidor'),
            );
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        NetworkImage(snapshot.data![index]['imageLink']),
                  ),
                  title: Text(
                      '${snapshot.data![index]['symbol']} - ${snapshot.data![index]['name'.toString()]}'),
                  subtitle: Column(
                    children: <Widget>[
                      ButtonBar(children: [
                        ElevatedButton(
                          child: Icon(Icons.edit),
                          onPressed: () {
                            nameController.text = snapshot.data![index]['name'];
                            symbolController.text =
                                snapshot.data![index]['symbol'];
                            priceController.text = snapshot.data![index]
                                    ['current_Price']
                                .toString();
                            marketcapController.text =
                                snapshot.data![index]['market_Cap'].toString();
                            imageController.text =
                                snapshot.data![index]['imageLink'];

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text('Editar'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Form(
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                labelText: 'Nome da Moeda',
                                                icon: Icon(Icons.account_box),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: symbolController,
                                              decoration: InputDecoration(
                                                labelText: 'Apelido',
                                                icon: Icon(Icons.euro_symbol),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: priceController,
                                              decoration: InputDecoration(
                                                labelText: 'Preço',
                                                icon: Icon(Icons.price_change),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: marketcapController,
                                              decoration: InputDecoration(
                                                labelText: 'Capitalização',
                                                icon: Icon(Icons.price_change),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: imageController,
                                              decoration: InputDecoration(
                                                labelText: 'Link da Imagem',
                                                icon: Icon(Icons.image),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          child: Text("Salvar"),
                                          onPressed: () async {
                                            String name = nameController.text;
                                            String symbol =
                                                symbolController.text;
                                            String price = priceController.text;
                                            String marketCap =
                                                marketcapController.text;
                                            String image = imageController.text;
                                            String id = snapshot.data![index]
                                                    ['id']
                                                .toString();

                                            var response = await updateCoin(
                                                name,
                                                symbol,
                                                price,
                                                marketCap,
                                                image,
                                                id);

                                            if (response == true) {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateListCoinRoute()),
                                              );
                                            }
                                          })
                                    ],
                                  );
                                });
                          },
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var response =
                                  await deleteCoin(snapshot.data![index]['id']);

                              if (response == true) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateListCoinRoute()),
                                );
                              }
                            },
                            child: Icon(Icons.delete))
                      ]),
                      Text(
                          'Preço da Moeda: R\$ ${snapshot.data![index]['current_Price'.toString()]} | Capitalização de Mercado : R\$ ${snapshot.data![index]['market_Cap'.toString()]} '),
                    ],
                  ),
                ));
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
