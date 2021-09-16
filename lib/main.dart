import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  
  static List student=[];
  int? sortColumnIndex = 0;
  bool isAscending = true ;
  Future<String>_loadAStudentAsset() async{
  return await rootBundle.loadString('../assets/StudentJson.json');
  }

  Future loadStudent() async {
    final String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
      setState(() {
        student = jsonResponse["Full"];
        // print(student); 
      });
    }
  
  @override
    void initState() {
      super.initState();
      loadStudent();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
        child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
           children: [
            Text(
              'Student Table',
              style: TextStyle(color: Colors.red,fontSize: 40.0,fontWeight:FontWeight.bold)
            ),
               Padding(padding: const EdgeInsets.all(40), 
               child:Row(
                children: [
                ElevatedButton(onPressed: loadStudent, child: Text('Reset'), style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),),
                Padding(padding: const EdgeInsets.all(11)),
                DropdownButton<String>(
                    style: TextStyle(color: Colors.black),
                    items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Gender",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    dropdownColor: Colors.grey,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 23,
                    underline: SizedBox(),
                    onChanged: (String? value){
                       setState(() {
                        String? _chosenGender = value;
                        student = student.where((val) => val["Gender"].contains(_chosenGender)).toList();
                      });
                    },
                ),
                Padding(padding: const EdgeInsets.all(11)),
                DropdownButton<String>(
                    style: TextStyle(color: Colors.black),
                    items: <String>['Undergraduat', 'Graduate'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                    hint:Text(
                      "Status",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    dropdownColor: Colors.grey,
                    icon: Icon(Icons.arrow_drop_down_circle),
                    iconSize: 23,
                    underline: SizedBox(),
                    // isExpanded: true,
                    
                    onChanged: (String? value){
                       setState(() {
                        String? _chosenStatus = value;
                        student = student.where((val) => val["StudentStatus"].contains(_chosenStatus)).toList();
                      });
                    },
              ),
          ],
          ),
          ),
        Card(
          child:
          PaginatedDataTable(
             onSelectAll: (b){},
            sortAscending: isAscending,
            sortColumnIndex: sortColumnIndex,
            columnSpacing: (MediaQuery.of(context).size.width *0.1136),
            source: MyData(),
            header: Text('Student Table'),
            columns: [
              DataColumn(
                      numeric:false, 
                        label: Text('Id ' , style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, fontWeight:FontWeight.bold),),
                         onSort: (columnIndex , _){
                          setState(() {
                            sortColumnIndex = columnIndex;
                            if(isAscending == true){
                              isAscending = false;
                              student.sort((a,b) => a["ID"].compareTo(b["ID"]));
                            }else{
                              isAscending = true;
                              student.sort((a,b) => b["ID"].compareTo(a["ID"]));
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
                              student.sort((a,b) => a["Age"].compareTo(b["Age"]));
                            }else{
                              isAscending = true;
                            student.sort((a,b) => b["Age"].compareTo(a["Age"]));

                            }
                            
                          });
                          
                        },
                        ),
            ],  
            
            horizontalMargin: 10,
            showCheckboxColumn: false,
            rowsPerPage:5,
          )
        ),
           ]
           )
        ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource{
  
  final List data = _MyHomePageState.student;
  // print(data);
  @override 
  DataRow getRow(int index)
  {
    return DataRow.byIndex(
      index: index,
      cells:[
        DataCell(Text('${data[index]['ID']}'.toString())),
        DataCell(Text('${data[index]['Gender']}',style: TextStyle(fontSize:13, fontWeight: FontWeight.w900),)),
        DataCell(Text('${data[index]['StudentStatus']}',style: TextStyle(fontSize:13, fontWeight: FontWeight.w900),)),
        DataCell(Text('${data[index]['Age']}'.toString(),style: TextStyle(fontSize:13, fontWeight: FontWeight.w900),))
      ]
    );

  }

  @override 
  int get selectedRowCount{
    return 0;
  }

  @override 
  bool get isRowCountApproximate {
    return false ;
  }

  @override 
  int get rowCount {
    return data.length;
  }
}