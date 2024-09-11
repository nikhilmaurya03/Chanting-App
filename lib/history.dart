import 'package:flutter/material.dart';
import 'dbfile.dart';

class History extends StatelessWidget {
 final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    //super.initState();
    _scrollController.position.jumpTo(0.0); // Scroll to the top of the list
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.amber
            : const Color.fromARGB(255, 71, 53, 1),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: CountDatabase.instance.readDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No records found.'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              reverse: true,
              shrinkWrap: false,
              controller: _scrollController,
              
             scrollDirection: Axis.vertical,
             
              itemBuilder: (context, index) {
                var record = snapshot.data![index];
              //  _scrollController.position.jumpTo(0);
                return Card(
                  elevation: 5,
                  //color: Colors.blue[200],
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.blue[200]
                      : const Color.fromARGB(255, 3, 31, 63),
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      'Date: ${record[CountDatabase.columnDate]}',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Count: ${record[CountDatabase.columnCount]}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

//  @override
//   void initState() {
//     super.initState();
//     _scrollController.po; // Scroll to the top of the list
//   }

