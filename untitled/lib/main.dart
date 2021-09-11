
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'data/ApiResponse.dart';


void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Barcode')
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  var barcode='8801062518210'; //++++바코드 입력받음!

  @override
  _MyHomePageState createState() => _MyHomePageState(barcode);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  //Image image1;
  String authkey ='33bdb62172294843a400';
  String authkey2 = 'Gj5JY2TDy07OsBlp%2F49dXG87xxg5MVf221%2FuJnysOWMhbqS5V9LELnodfK025BwqZpSMM2rtG%2BT2UrGBJDgoog%3D%3D';
  // 너무 길이서 변수로 나눔.
  //var jsonString1='{"C005":{"RESULT":{"MSG":"정상처리되었습니다.","CODE":"INFO-000"},';
  //var jsonString2='"total_count":"100797","row":[{"BAR_CD":"123","PRDLST_NM":"123","PRDLST_REPORT_NO":"123"},';
  //var jsonString3='{"BAR_CD":"111","PRDLST_NM":"111","PRDLST_REPORT_NO":"111"}]}}';
  //var jsonString;

  void getFoodNum(String barcd)async {
    var jsonUrl = "http://openapi.foodsafetykorea.go.kr/api/$authkey/C005/json/1/5" +
        '/BAR_CD=$barcd';
    var response = await http.get(Uri.parse(jsonUrl));
    var result=BarcodeApiResponse.fromJson(jsonDecode(response.body));
    //print(result.c005.result.message);
    //print(result.c005.row[0].name);
    //String keynum = result.c005.row[0].foodnum;
    var jsonUrl2 = "http://apis.data.go.kr/B553748/CertImgListService/getCertImgListService?serviceKey=$authkey2"+"&returnType=json&prdlstReportNo="+result.c005.row[0].foodnum;
    var response2 = await http.get(Uri.parse(jsonUrl2));
    var result2 = BarcodeApiResponse2.fromJson(jsonDecode(response2.body));
    print(result2.list[0].nutrient);
    print(result2.list[0].rawmtrl);
    print(result2.list[0].img);
    print(result2.list[0].capacity);
    print(result2.list[0].allergy);
    String rawmtrl = result2.list[0].rawmtrl;
    var arr = rawmtrl.split(',');
    for(int i = 0;i<9;i++){
      print(arr[i]);
    }
    print(arr);
  }_MyHomePageState(String barcode){
    //jsonString='$jsonString1$jsonString2$jsonString3';
    getFoodNum(barcode);
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
