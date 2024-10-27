import 'dart:math';
import 'package:despesas/componentes/chart.dart';
import 'package:flutter/material.dart';
import 'package:despesas/models/transacao.dart';
import 'componentes/transaction_list.dart';
import 'package:despesas/componentes/transaction_form.dart';

main() => runApp(const DespesasApp());

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const MyHomePage(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ))));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> transacao = [
    // Transacao(
    //     id: 't1',
    //     titulo: 'Novo tênis de Corrida',
    //     valor: 310.76,
    //     data: DateTime.now().subtract(const Duration(days: 2))),
    // Transacao(
    //     id: 't2',
    //     titulo: 'Conta de Luz',
    //     valor: 211.30,
    //     data: DateTime.now().subtract(const Duration(days: 4))),
  ];

  List<Transacao> get transacaoRecente {
    return transacao.where((tr) {
      return tr.data.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  addTransacao(String titulo, double valor, DateTime data) {
    final newTransacao = Transacao(
        id: Random().nextDouble().toString(),
        titulo: titulo,
        valor: valor,
        data: data);

    setState(() {
      transacao.add(newTransacao);
    });
    Navigator.of(context).pop();
  }

  removeTransacao(String id) {
    setState(() {
      transacao.removeWhere((tr) => tr.id == id);
    });
  }

  openFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(addTransacao);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Theme.of(context).primaryColor,
        ),
        title: const Center(
            child: Text(
          'Despesas Pessoais',
          style: TextStyle(color: Colors.white),
        )),
        actions: <Widget>[
          IconButton(
            onPressed: () => openFormModal(context),
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(transacaoRecente),
            TransactionList(
              transacao: transacao,
              onRemove: removeTransacao,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openFormModal(context),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
