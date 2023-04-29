import 'package:flutter/material.dart';
import '../../functions/email_to_uid.dart';
import '../../models/group_model.dart';

class BalancesPage extends StatefulWidget {
  final GroupModel model;
  const BalancesPage({Key? key, required this.model}) : super(key: key);

  @override
  State<BalancesPage> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  List<bool> isOpen = List.filled(100, false, growable: false);

  @override
  Widget build(BuildContext context) {
    List<String> people = widget.model.balances.keys.toList();
    List<double> totals = [];
    for (var person in widget.model.balances.keys) {
      double counter = 0;
      for (var person2 in widget.model.balances[person]!.keys) {
        counter += widget.model.balances[person]![person2]!;
      }
      totals.add(counter);
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Balances'),
        ),
        body: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (i, isO) {
              setState(() {
                isOpen[i] = !isO;
              });
            },
            children: [
              for (int i = 0; i < widget.model.balances.length; i++)
                ExpansionPanel(
                    headerBuilder: (context, isOpen) {
                      return Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                text: UIDN(people[i]),
                              ),
                              TextSpan(
                                  text: totals[i] > 0
                                      ? ' gets back '
                                      : totals[i] < 0
                                          ? ' owes '
                                          : ' is settled '),
                              TextSpan(
                                  text: totals[i] != 0
                                      ? '\u{20B9}${totals[i].abs().toStringAsFixed(2)}'
                                      : '',
                                  style: TextStyle(
                                      color: totals[i] > 0
                                          ? Colors.green
                                          : Colors.orange)),
                              const TextSpan(
                                text: ' in total',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var person
                            in widget.model.balances[people[i]]!.keys)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: UIDN(person),
                                  ),
                                  TextSpan(
                                      text: widget.model.balances[people[i]]![
                                                  person]! >
                                              0
                                          ? ' owes '
                                          : widget.model.balances[people[i]]![
                                                      person]! <
                                                  0
                                              ? ' gets back '
                                              : ' is settled up'),
                                  TextSpan(
                                      text: widget.model.balances[people[i]]![
                                                  person]! !=
                                              0
                                          ? '\u{20B9}${widget.model.balances[people[i]]![person]!.abs().toStringAsFixed(2)}'
                                          : '',
                                      style: TextStyle(
                                          color: widget.model.balances[
                                                      people[i]]![person]! >
                                                  0
                                              ? Colors.green
                                              : Colors.orange)),
                                  TextSpan(
                                    text: widget.model
                                                .balances[people[i]]![person]! >
                                            0
                                        ? ' to ${UIDN(people[i])}'
                                        : widget.model.balances[people[i]]![
                                                    person]! <
                                                0
                                            ? ' from ${UIDN(people[i])}'
                                            : ' with ${UIDN(people[i])}',
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                    isExpanded: isOpen[i])
            ],
          ),
        ),
      ),
    );
  }
}
