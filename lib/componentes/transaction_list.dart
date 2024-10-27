import 'package:despesas/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transacao> transacao;
  final void Function(String) onRemove;

  const TransactionList(
      {super.key, required this.transacao, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transacao.isEmpty
          ? Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text('Nenhuma transação cadastrada!',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transacao.length,
              itemBuilder: (ctx, index) {
                final tr = transacao[index];
                return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                        leading: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                'R\$${tr.valor.toStringAsFixed(2)}',
                                style: const TextStyle(fontFamily: 'Quicksand'),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          tr.titulo,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(DateFormat('d MMM y').format(tr.data)),
                        trailing: IconButton(
                            onPressed: () => onRemove(tr.id),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))));
              }),
    );
  }
}
