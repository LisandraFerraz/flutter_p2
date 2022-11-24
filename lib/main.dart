import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Prestações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.amber,
        primaryColor: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: 
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: 
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.lightBlueAccent)
        )
      ),
      home: const MyHomePage(title: 'Cálculo de Prestações'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  
  final primeiraPrestacao = TextEditingController(); 
  final prestacaoAnual = TextEditingController();  
  final prestacaoFinal = TextEditingController();

  String _mensagem = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int valorPagar = 80;
  int anos = 0;

  void _limpaCampos(){
    primeiraPrestacao.clear();
    prestacaoAnual.clear();
    prestacaoFinal.clear();
      setState(() {
        _mensagem = "Informe os dados necessários";
        _formKey = GlobalKey<FormState>();
      });
  }

  calculoValor(){
    setState(() {
      valorPagar = int.parse(primeiraPrestacao.text);

      for (int i = 0; valorPagar <= 5000; i++){
        valorPagar = valorPagar + valorPagar;

        if (valorPagar >= 5000){
          _mensagem = "Em ${i} anos, a prestação estará acima de 5.000,00 reais. No ${i}º ano, o valor da parcela será de: ${valorPagar} reais.";
          return;
        }
      }
    });
  }

  Widget construirTextField(String texto, String prefixo, TextEditingController c, String mensagemErro){
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty){
          return mensagemErro;
        } else {
          return null;
        }
      },
      controller: c,
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: const TextStyle(color: Colors.blue),
        border: const OutlineInputBorder(),
        prefixText: prefixo
      ),
      style: const TextStyle(
        color: Colors.black
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: _limpaCampos, icon: const Icon(Icons.refresh))
        ],
      ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.payment,
              size: 150,
              color: Color.fromARGB(255, 189, 212, 250)
            ),
          construirTextField("Valor da primeira prestação", "Informe:", primeiraPrestacao, "Erro"),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                        calculoValor();
                    }
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(fontSize: 30, color: Colors.amber),
                  ),
              ),
            ),
            Center(
              child: Text(
                _mensagem,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
