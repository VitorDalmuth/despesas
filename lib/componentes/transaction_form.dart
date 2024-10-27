import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();
  DateTime? dataSelecionada = DateTime.now();

  submitForm() {
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0.0;
    if (titulo.isEmpty || valor <= 0 || dataSelecionada == null) {
      return;
    }
    widget.onSubmit(titulo, valor, dataSelecionada!);
  }

  dynamic _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dataSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: tituloController,
                  onSubmitted: (_) => submitForm(),
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                  ),
                ),
                TextField(
                  controller: valorController,
                  onSubmitted: (_) => submitForm(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                  ),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(dataSelecionada == null
                              ? 'Nenhuma data selecionada'
                              : 'Data selecionada: ${DateFormat('dd/MM/y').format(dataSelecionada!)}')),
                      TextButton(
                          onPressed: _showDatePicker,
                          child: Text('Selecione uma data!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor))),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: submitForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: const Text('Nova Transação',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            )));
  }
}
