import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'transfer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  final controller = TextEditingController();
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  List<Truc> trucs = [];
void getHttpListComplex(String nom) async{
    try{
      var response =await Dio().get('https://api.github.com/users/'+nom+'/repos');
      print(response);
      var listeJSON = response.data as List;
      var listeTruc = listeJSON.map(
          (elementJSON){
            return Truc.fromJson(elementJSON);
          }
      ).toList();
      this.trucs = listeTruc;
      setState(() {});
    } catch (e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur reseau'))
      );
    }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            ListView.builder(
              itemCount: trucs.length,
              itemBuilder: (context, int index){
                return Container(
                  child: ListTile(
                    tileColor: Colors.blueAccent,
                    title: new Center(child: Text(trucs[index].name + trucs[index].private.toString(), style: new TextStyle( fontWeight: FontWeight.w500, fontSize: 25.0),
                )
                ),
                )
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getHttpListComplex('${controller.text}');
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
