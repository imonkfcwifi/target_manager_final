import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_manager/constants/sizes.dart';

import '../db/db.dart';

// MVVM 방식으로 분류할 필요성이 있음
class NumberPad extends StatefulWidget {
  const NumberPad({super.key});

  @override
  NumberPadState createState() => NumberPadState();
}

Future<void> _saveData(int total, int count, double average) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('total', total);
  await prefs.setInt('count', count);
  await prefs.setDouble('average', average);
}

class NumberPadState extends State<NumberPad> {
  int _total = 0;
  int _count = 0;
  double _average = 0.0;
  bool selected = false;
  int _lastNumber = 0;
  final List<int> _numbers = [];

  @override
  void initState() {
    super.initState();
  }

  void _removeLastNumber() {
    if (_numbers.isNotEmpty) {
      final lastNumber = _numbers.removeLast();
      if (_count > 0) {
        _count--;
        if (_total >= lastNumber) {
          _total -= lastNumber;
        }
      }
      _average = _count == 0 ? 0 : _total / _count;
      setState(() {});
    }
  }

  void _addToTotal(int number) async {
    setState(() {
      _numbers.add(number);
      _total += number;
      _count++;
      _average = _total / _count;
      _lastNumber = number;
    });
  }

  Future<void> _saveData(int total, int count, double average) async {
    final dbHelper = DbHelper();
    await dbHelper.saveResult(total, count, average);
  }

  Widget _buildNumberButton(int number) {
    return GestureDetector(
      onTap: () {
        _addToTotal(number);
        final player = AudioPlayer();
        player.play(
          AssetSource('1.mp3'),
        );
      },
      onLongPress: () {
        if (_count > 0) {
          setState(() {
            _total -= number;
            _count--;
            _average = _count > 0 ? _total / _count : 0.0;
          });
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(fontSize: 42, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '타겟 매니저 Beta 1.0 ',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total: $_total',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                'Count: $_count',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                'Average: ${_average.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                'Recent: $_lastNumber',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(1),
                  _buildNumberButton(2),
                  _buildNumberButton(3),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(4),
                  _buildNumberButton(5),
                  _buildNumberButton(6),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(7),
                  _buildNumberButton(8),
                  _buildNumberButton(9),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildNumberButton(10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(Sizes.size16),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed:
                        _removeLastNumber, // changed to cancel last number
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(Sizes.size16),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    onPressed: () async {
                      await _saveData(_total, _count, _average);
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Target Manager'),
                            content: Text(
                              '수고하셨습니다.\nTotal: $_total\nCount: $_count\nAverage: ${_average.toStringAsFixed(2)}',
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Save Data'),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                    animationDuration:
                                        Duration(milliseconds: 300)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
