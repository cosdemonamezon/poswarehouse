import 'package:flutter/material.dart';
import 'package:poswarehouse/screen/drawer/appDrawerPage.dart';
import 'package:poswarehouse/screen/home/services/homeController.dart';
import 'package:poswarehouse/screen/home/widgets/cardDashboardWidget.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String year = "";
  String dropdownvalue = '2023';
  DateTime now = DateTime.now();
  var items = [
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',
  ];

  @override
  void initState() {
    super.initState();    
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    LoadingDialog.open(context);
    setState(() {
      DateTime date = DateTime(now.year);
      year = date.year.toString();
      dropdownvalue = date.year.toString();
    });
    await context.read<HomeController>().getAllReports(year);
    LoadingDialog.close(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (context, controller, child) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  controller.homeReport.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            controller.homeReport.length,
                            (index) => Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                                  child: CardDashboardWidget(
                                    size: size,
                                    iconData: Icons.token,
                                    title: 'ยอดขายวันนี้',
                                    price: '${controller.homeReport[index]['total1']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                                  child: CardDashboardWidget(
                                    size: size,
                                    iconData: Icons.token,
                                    title: 'ยอดขายรายเดือน',
                                    price: '${controller.homeReport[index]['total2']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                                  child: CardDashboardWidget(
                                    size: size,
                                    iconData: Icons.token,
                                    title: 'ยอดซื้อวันนี้',
                                    price: '${controller.homeReport[index]['total3']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                                  child: CardDashboardWidget(
                                    size: size,
                                    iconData: Icons.token,
                                    title: 'ยอดซื้อเดือนนี้',
                                    price: '${controller.homeReport[index]['total4']}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                      child: Column(children: [
                        Container(
                          width: size.width * 0.80,
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
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                                        onChanged: (String? newValue) async{
                                          setState(() {
                                            dropdownvalue = newValue!;
                                            year = newValue;
                                          });
                                          //_initialize();
                                          LoadingDialog.open(context);
                                          await context.read<HomeController>().getAllReports(year);
                                          LoadingDialog.close(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              controller.homeReport.isNotEmpty
                                  ? Column(
                                      children: List.generate(
                                      controller.homeReport.length,
                                      (index) => Container(
                                        width: size.width * 0.60,
                                        child: SfCartesianChart(
                                          primaryXAxis: CategoryAxis(),
                                          //primaryYAxis: CategoryAxis(),
                                          series: <ChartSeries>[
                                            LineSeries<ChartData, String>(
                                              dataSource: List.generate(
                                                controller.homeReport[index]['orders'].length,
                                                (index1) => ChartData('${controller.homeReport[index]['orders'][index1]['month_th']}',
                                                    controller.homeReport[index]['orders'][index1]['price']),
                                              ),
                                              xValueMapper: (ChartData data, _) => data.x,
                                              yValueMapper: (ChartData data, _) => data.y,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int? y;
}
