import 'package:flutter/foundation.dart';
import 'dbfile.dart';

class CountProvider with ChangeNotifier {
  var date = DateTime.now().toIso8601String().split('T').first;
  int _times = 0;
  int get times => _times; // getter is created for accessing in another class

  int _counter = -1;
  int get counter => _counter;

  int _yellowcounter = -4;
  int get yellowcounter => _yellowcounter;

  int _bluecounter = -3;
  int get bluecounter => _bluecounter;

  int _greencounter = -2;
  int get greencounter => _greencounter;

  int _redcounter = -1;
  int get redcounter => _redcounter;

  CountProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadInitialCount(date);
    notifyListeners();
  }

  Future<void> _loadInitialCount(String date) async {
    
    var records = await CountDatabase.instance.readDatabase();

    for (var record in records) {
      if (record[CountDatabase.columnDate] == date) {
        _times = record[CountDatabase.columnCount];
        print('in loop times = $_times');
        break;
      }
      print("records loop over");
    }
    //notifyListeners();
  }

  void setCount() {
    _counter++;
    if (_counter - _yellowcounter == 4) {
      _yellowcounter += 4;
    }
    if (_counter - _bluecounter == 4) {
      _bluecounter += 4;
    }
    if (_counter - _greencounter == 4) {
      _greencounter += 4;
    }
    if (_counter - _redcounter == 4) {
      _redcounter += 4;
    }
    // _loadInitialCount();
    if (counter == 108) {
      print('initial _times = $_times');

      _times++;

      print('after increment _times = $_times');

      _dbinsertRecord(_times, date);

      _counter = 0;
      _yellowcounter = -3;
      _bluecounter = -2;
      _greencounter = -1;
      _redcounter = 0;
    }
    notifyListeners();
  }

  Future<void> _dbinsertRecord(int times, String date) async {
    List<Map<String, dynamic>> show_count = [];
     //date = DateTime.now().toIso8601String().split('T').first;
    //print(date);

    var read = await CountDatabase.instance.readDatabase();
    bool dateExists = false;
    int existingId = -1;

    for (var record in read) {
      if (record[CountDatabase.columnDate] == date) {
        dateExists = true;
        print(dateExists);
        existingId = record[CountDatabase.columnId];
        print(existingId);
        break;
      }
    }
    if (!dateExists) {
      await CountDatabase.instance.insertRecord(
          {CountDatabase.columnDate: date, CountDatabase.columnCount: times});
    } else {
      await CountDatabase.instance.updateRecord({
        CountDatabase.columnId: existingId,
        CountDatabase.columnCount: times,
      });
    }
    read = await CountDatabase.instance.readDatabase();
    show_count = read;
    print(show_count);
  }
}
