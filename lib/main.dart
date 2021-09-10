import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
// import 'package:sizes/sizes_helpers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      title: 'Read Json',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List _items = [];
  

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('../assets/StudentJson.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["Full"];
      // print(_items[0]["LastName"]);
    });
    //  print(_items);
  }

  @override
    void initState() {
      super.initState();
      readJson();
    }

  Widget build(BuildContext context) {

    
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     'Read Json',
        //   ),
          
        // ),
      backgroundColor: Colors.white30,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
        child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        
        child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          
           children: [
            Text(
              'Student Table',
              style: TextStyle(color: Colors.red,fontSize: 40.0,fontWeight:FontWeight.bold)
            ),
             Card(
               child: 
             DataTable(
                  columnSpacing: (MediaQuery.of(context).size.width *0.005),
                  dataRowHeight: 80,
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black38),
                  columns: [
                    DataColumn(
                      numeric:false, 
                        label: Text('Id ' , style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, fontWeight:FontWeight.bold),),
                        ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('LName ', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('FName ', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('City', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('State', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    DataColumn(
                      numeric:false,
                        label: Text('Gender ', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                        ),
                    DataColumn(
                      numeric:false,
                        label: Text('Status', style: TextStyle( fontSize: 15, fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                        ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('Major', style: TextStyle(  fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('Country', style: TextStyle( fontSize: 15, fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    DataColumn(
                      numeric:false,
                        label: Text('Age', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
                        ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('SAT', style: TextStyle(  fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('Grade ', style: TextStyle(  fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                    // DataColumn(
                    //   numeric:false,
                    //     label: Text('Height', style: TextStyle( fontSize: 15, fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                    //     ),
                  ],
                  rows: _items.map<DataRow>(((val) => 
                    
                      DataRow(
                        cells: [
                          DataCell(
                              Container(
                                color: Colors.white30,
                                width: (MediaQuery.of(context).size.width * 0.07) ,
                                child:
                                Text(val["ID"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                            )
                            ),
                          // DataCell(
                          //   Container(color: Colors.white30,
                          //     width: (MediaQuery.of(context).size.width * 0.15) , 
                          //    child:
                          //    Text(val["LastName"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                          //   )),
                          // DataCell(
                          //   Container(
                          //   width: (MediaQuery.of(context).size.width * 0.15 ) ,
                          //    child:
                          //   Text(val["FirstName"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                          // )),
                          // DataCell(Container(
                          // width: (MediaQuery.of(context).size.width * 0.15) ,
                          //    child:
                          //   Text(val["City"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                          // )),
                          // DataCell(Container(
                          //  width: (MediaQuery.of(context).size.width * 0.15) ,
                          //    child:
                          //   Text(val["State"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                          // )),
                          DataCell(Container(
                            
                            width: (MediaQuery.of(context).size.width * 0.22) ,
                             child:
                            Text(val["Gender"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                          )),
                          DataCell(Container(
                          width: (MediaQuery.of(context).size.width * 0.22) ,
                             child:
                            Text(val["StudentStatus"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900),)
                          )),
                          // DataCell(Container(width: (MediaQuery.of(context).size.width * 0.13 ) ,
                          //    child:
                          //   Text(val["Major"])
                          // )),
                          // DataCell(Container(width: (MediaQuery.of(context).size.width * 0.15 ) ,
                          //    child:
                          //   Text(val["Country"], style: TextStyle(fontSize:  MediaQuery.of(context).size.width >500 ?15 : MediaQuery.of(context).size.width <375? 11 :13, fontWeight: FontWeight.w900))
                          // )),
                          DataCell(Container(width: (MediaQuery.of(context).size.width * 0.22 ) ,
                             child:
                            Text(val["Age"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),)
                          )),
                          // DataCell(Container(width: (MediaQuery.of(context).size.width * 0.13) ,
                          //    child:
                          //   Text(val["SAT"])
                          // )),
                          // DataCell(Container(width: (MediaQuery.of(context).size.width * 0.13 ) ,
                          //    child:
                          //   Text(val["Grade "])
                          //  ) ),
                          // DataCell(Container(width: (MediaQuery.of(context).size.width * 0.15 ) ,
                          //    child:
                          //   Text(val["Height"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900))
                          // )),
                        ],
                      )),).toList()
                ),
                elevation: 10,
             )
               
                //   ElevatedButton(
                //     child: Text('All Student'),
                //     onPressed: readJson,
                //   ),

          
          ],
        ),
      ),

        )
        )
        ) 
    );
  }
}
// children: [
//             ElevatedButton(
//               child: Text('All Student'),
//               onPressed: readJson,
//             ),

//             // Display the data loaded from sample.json
//             _items.length > 0
//                 ? Expanded(
//                     child: ListView.builder(
//                       itemCount: _items.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           margin: EdgeInsets.all(10),
//                           child: ListTile(
//                             leading: Text(_items[index]["ID"]),
//                             title: Text(_items[index]["FirstName"]),
//                             subtitle: Text(_items[index]["City"]),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 : Container()
//           ],