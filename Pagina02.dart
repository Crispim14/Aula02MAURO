import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Pagina02()));
}

class Pagina02 extends StatefulWidget {
  const Pagina02({Key? key}) : super(key: key);

  @override
  State<Pagina02> createState() => _Pagina02State();
}

class _Pagina02State extends State<Pagina02> {
  final TextEditingController _nomeController = TextEditingController();
  final List<TextEditingController> _notaControllers =
      List.generate(4, (_) => TextEditingController());
  String _resultado = '';

  void _calculaMedia() {
    double somaNotas = 0.0;
    for (var controller in _notaControllers) {
      double? nota = double.tryParse(controller.text);
      if (nota == null) {
        setState(() {
          _resultado = "Por favor, digite valores válidos para todas as notas.";
        });
        return;
      }
      somaNotas += nota;
    }
    double media = somaNotas / _notaControllers.length;
    setState(() {
      _resultado =
          "${_nomeController.text} obteve média ${media.toStringAsFixed(1)}.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo da Média'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Aluno',
              ),
            ),
            ..._notaControllers.asMap().entries.map((entry) {
              int idx = entry.key;
              TextEditingController controller = entry.value;
              return TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Nota ${idx + 1}',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              );
            }).toList(),
            ElevatedButton(
              onPressed: _calculaMedia,
              child: const Text('Calcular Média'),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
