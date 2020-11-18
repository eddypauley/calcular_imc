import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _result = "Informe o peso a a altura e clique em calcular!";
  double _weight = 0.0;
  double _height = 0.0;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _weight = 0.0;
      _height = 0.0;

      _result = "Informe o peso a a altura e clique em calcular!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      _weight = double.parse(weightController.text);
      _height = double.parse(heightController.text) / 100;
      double imc = _weight / (_height * _height);

      print(imc);
      if (imc < 18.6) {
        _result = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _result = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _result = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _result = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _result = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 39.9) {
        _result = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      } else {
        _result = "Nenhum";
      }
    });
  }

  String _validateWeight(String value) {
    if (value.isEmpty) {
      return "Informe seu peso!";
    }
    return null;
  }

  String _validateHeight(String value) {
    if (value.isEmpty) {
      return "Informe sua altura!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              textFormField("Peso (Kg)", weightController, _validateWeight),
              textFormField("Altura (cm)", heightController, _validateHeight),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: text("Calcular", Colors.white, 25.0),
                    color: Colors.green,
                  ),
                ),
              ),
              text(_result, Colors.green, 25.0)
            ],
          ),
        ),
      ),
    );
  }
}

textFormField(String label, TextEditingController controller, validator) {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label, labelStyle: TextStyle(color: Colors.green)),
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.green, fontSize: 25.0),
    controller: controller,
    validator: validator,
  );
}

text(String label, Color color, double size) {
  return Text(
    label,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: size),
  );
}
