import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/count_provider.dart';

class Today extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
   // final countProvider = Provider.of<CountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ISKON'),
        backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.amber:const Color.fromARGB(255, 71, 53, 1),
      ),
      body: Center(
        child: Container(
            width: 300,  
        height: 200,  
        padding: new EdgeInsets.all(10.0),  
          child: Card(
             shape: RoundedRectangleBorder(  
            borderRadius: BorderRadius.circular(15.0), 
            
          ),
               color: Colors.pink,
               elevation: 10,
               child: Column(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Today rounds', style: TextStyle(fontSize: 20),),

                  Consumer<CountProvider>(builder: (context, value, child){
                    return Text(value.times.toString(), style: TextStyle(fontSize: 30));
                  }),

                  ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text('back'))
                ],
               ),  
        ),
      ),
      ),
    );
  }
}
