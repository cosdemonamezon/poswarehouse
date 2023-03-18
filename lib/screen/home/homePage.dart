import 'package:flutter/material.dart';
import 'package:poswarehouse/screen/drawer/appDrawerPage.dart';
import 'package:poswarehouse/screen/home/widgets/cardDashboardWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownvalue = 'ยอดขายรวม';
  var items = [
    'ยอดขายรวม',
    'ยอดขายรายปี',
    'ยอดขายรายเดือน',
    'ยอดขายรายสัปดาห์',
    'ยอดขายวันนี้',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ภาพรวม'),
      ),
      drawer: AppDrawerPage(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardDashboardWidget(
                      size: size,
                      iconData: Icons.token,
                      title: 'ยอดขายวันนี้',
                      price: '12,999',
                    ),
                    CardDashboardWidget(
                      size: size,
                      iconData: Icons.token,
                      title: 'ยอดขายรายเดือน',
                      price: '241,587',
                    ),
                    CardDashboardWidget(
                      size: size,
                      iconData: Icons.token,
                      title: 'ยอดซื้อวันนี้',
                      price: '50,000',
                    ),
                    CardDashboardWidget(
                      size: size,
                      iconData: Icons.token,
                      title: 'ยอดซื้อเดือนนี้',
                      price: '107,557',
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFF3F3F3),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          size: 30,
                                        ),
                                        Text(
                                          'ยอดขายรวม',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: DropdownButton(
                                      value: dropdownvalue,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.40,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                //primaryYAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  LineSeries<ChartData, String>(
                                    dataSource: [
                                      ChartData('Jan', 10),
                                      ChartData('Feb', 20),
                                      ChartData('Mar', 22),
                                      ChartData('Apr', 12),
                                      ChartData('May', 9),
                                      ChartData('Jun', 15),
                                      ChartData('Jul', 18),
                                      ChartData('Og', 100)
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Card show store 
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFFF3F3F3),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: size.width * 0.45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_cart,
                                          size: 30,
                                        ),
                                        Text(
                                          'มูลค่าสินค้าคงหลือรายคลัง',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: DropdownButton(
                                      value: dropdownvalue,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.40,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                //primaryYAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  LineSeries<ChartData, String>(
                                    dataSource: [
                                      ChartData('Jan', 35),
                                      ChartData('Feb', 28),
                                      ChartData('Mar', 34),
                                      ChartData('Apr', 32),
                                      ChartData('May', 40)
                                    ],
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
