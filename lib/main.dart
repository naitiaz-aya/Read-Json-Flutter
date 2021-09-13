import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
// import 'dart:math';
// import 'package:newflutterapp/DropdownButton.dart';

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
  int? sortColumnIndex = 0;
  bool isAscending = true ;
  // DataTableSource _data = MyData();

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('../assets/StudentJson.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["Full"];
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
               Padding(padding: const EdgeInsets.all(45), 
               child:Row(
                children: [
                DropdownButton<String>(
                    style: TextStyle(color: Colors.black),

                    items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Gender",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value){
                       setState(() {
                        String? _chosenGender = value;
                        _items = _items.where((val) => val["Gender"].contains(_chosenGender)).toList();
                      });
                      
                    },
                    
            ),
            DropdownButton<String>(
                    style: TextStyle(color: Colors.black),

                    items: <String>['Undergraduat', 'Graduate'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Staus",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value){
                       setState(() {
                        String? _chosenStatus = value;
                        //  readJson();
                        _items = _items.where((val) => val["StudentStatus"].contains(_chosenStatus)).toList();
                        
                      });
                    },
            ),
          ],
          ),
          ),
           
             Card(
              
              child:
              DataTable(
                  onSelectAll: (b){},
                  sortAscending: isAscending,
                  sortColumnIndex: sortColumnIndex,
                  columnSpacing: (MediaQuery.of(context).size.width *0.005),
                  dataRowHeight: 80,
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black38),
                  columns: [
                    DataColumn(
                      numeric:false, 
                        label: Text('Id ' , style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, fontWeight:FontWeight.bold),),
                         onSort: (columnIndex , _){
                          setState(() {
                            sortColumnIndex = columnIndex;
                            if(isAscending == true){
                              isAscending = false;
                              _items.sort((a,b) => a["ID"].compareTo(b["ID"]));

                            }else{
                              isAscending = true;
                            _items.sort((a,b) => b["ID"].compareTo(a["ID"]));

                            }
                            
                          }
                        );
                          
                        },
                        ),
                    
                    DataColumn(
                      numeric:false,
                        label: Text('Gender ', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                        ),
                    DataColumn(
                      numeric:false,
                        label: Text('Status', style: TextStyle( fontSize: 15, fontStyle: FontStyle.italic,fontWeight:FontWeight.bold),),
                        ),
                    
                    DataColumn(
                      numeric:false,
                        label: Text('Age', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,fontWeight:FontWeight.bold)),
                        
                         onSort: (columnIndex , _){
                          setState(() {
                            sortColumnIndex = columnIndex;
                            if(isAscending == true){
                              isAscending = false;
                              _items.sort((a,b) => a["Age"].compareTo(b["Age"]));

                            }else{
                              isAscending = true;
                            _items.sort((a,b) => b["Age"].compareTo(a["Age"]));

                            }
                            
                          });
                          
                        },
                        ),
                    
                  ],
                  // rowsPerPage: 8,

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
                         
                          DataCell(Container(width: (MediaQuery.of(context).size.width * 0.22 ) ,
                             child:
                            Text(val["Age"], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),)
                          )),
                         
                        ],
                      )
                      ),
                      )
                      .toList()
                ),
                elevation: 10,
             )
               
                
          
          ],
        ),
        
      ),
        
        )
        )
        ) 
    );
  }
}
class MyDataTableSource extends DataTableSource{
  MyDataTableSource(this.items);
  final List items;

  @override 
  DataRow getRow(int index)=> DataRow.byIndex(
      index: index,
      cells:[
        DataCell(Text('${items[index]['ID']}')),
        DataCell(Text('${items[index]['Gender']}',style: TextStyle(fontSize:13, fontWeight: FontWeight.w900),)),
        DataCell(Text('${items[index]['StudentStatus']}',style: TextStyle(fontSize:13, fontWeight: FontWeight.w900),)),
        DataCell(Text('${items[index]['Age']}',style: TextStyle(fontSize:13, fontWeight: FontWeight.w900),))
      ],
    );
  

  @override 
  int get selectedRowCount{
    return 0;
  }
  
  @override 
  bool get isRwoCountApproximate {
    return false ;
  }
                
  @override 
  int get rowCount {
    return items.length;
  }
}