import 'package:flutter/material.dart';
import 'package:target_manager/features/db/db.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({Key? key}) : super(key: key);

  @override
  _ResultListScreenState createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
  late Future<List<Record>> _futureRecords;

  @override
  void initState() {
    _futureRecords = DbHelper().getResult();
    super.initState();
  }

  Future<void> _ondis(List<Record> records, int index) async {
    final record = records.toList()[index];
    DbHelper().deleteRecord(record.id ?? 0);
    setState(() {
      records.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '슈팅기록',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Record>>(
        future: _futureRecords,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final records = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return Card(
                        child: Dismissible(
                          onDismissed: (direction) => _ondis(records, index),
                          background: Container(
                            color: Colors.red,
                          ),
                          key: Key(record.id.toString()),
                          child: ListTile(
                            title: Text(
                              'Total: ${record.total}, Count: ${record.count}, Average: ${record.average.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
