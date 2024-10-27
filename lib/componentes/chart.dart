import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transacao.dart';
import 'chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacaoRecente;

  const Chart(this.transacaoRecente, {super.key});

  List<Map<String, Object>> get grupoTransacoes {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double somaTotal = 0.0;

      for (var i = 0; i < transacaoRecente.length; i++) {
        bool sameDay = transacaoRecente[i].data.day == weekDay.day;
        bool sameMonth = transacaoRecente[i].data.month == weekDay.month;
        bool sameYear = transacaoRecente[i].data.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          somaTotal += transacaoRecente[i].valor;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'valor': somaTotal,
      };
    }).reversed.toList();
  }

  double get totalSemana {
    return grupoTransacoes.fold(0.0, (soma, tr) {
      return soma + (tr['valor'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupoTransacoes.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                valor: double.parse(tr['valor'].toString()),
                porcentagem: totalSemana == 0
                    ? 0
                    : (tr['valor'] as double) / totalSemana,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
