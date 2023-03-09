import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allProduct.dart';
import 'package:poswarehouse/models/product.dart';

class ProductDialog extends StatefulWidget {
  ProductDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.press,required this.pressSelect,this.allProduct,this.selectProducts})
      : super(key: key);
  final String title, description;
  final VoidCallback press;
  final VoidCallback pressSelect;
  AllProduct? allProduct;
  List<Product>? selectProducts;

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  List<Product> newSelectProducts = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: size.width * 0.70,
        height: size.height * 0.75,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: widget.press,
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.blueAccent,
                      )),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Center(
                child: Text('เลือกสินค้า',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              widget.allProduct != null
              ?Container(
                //color: Colors.blue,
                height: size.height * 0.45,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey)),
                        child: widget.allProduct!.data!.isNotEmpty
                        ?DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text('รหัส'),
                              ),
                              DataColumn(
                                label: Text('ชื่อสินค้า'),
                              ),
                              DataColumn(
                                label: Text('รูปภาพ'),
                              ),
                              DataColumn(
                                label: Center(child: Text('ราคาทุน')),
                              ),
                              DataColumn(
                                label: Center(child: Text('ราคาขายส่ง')),
                              ),
                              DataColumn(
                                label: Center(child: Text('ราคาขายปลีก')),
                              ),
                              DataColumn(
                                label: Center(child: Text('ราคายกลัง')),
                              ),
                              DataColumn(
                                label: Center(child: Text('คงเหลือ')),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                widget.allProduct!.data!.length,
                                (index) => DataRow(
                                      color: MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                        // All rows will have the same selected color.
                                        if (states.contains(MaterialState.selected)) {
                                          return Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.08);
                                        }
                                        // Even rows will have a grey color.
                                        if (index.isEven) {
                                          return Colors.grey.withOpacity(0.3);
                                        }
                                        return null; // Use default value for other states and odd rows.
                                      }),
                                      cells: <DataCell>[
                                        DataCell(Text('${widget.allProduct!.data![index].id}')),
                                        DataCell(Text('${widget.allProduct!.data![index].name}')),
                                        DataCell(SizedBox(
                                          width: size.width * 0.08,
                                          height: size.height * 0.10,
                                          child: widget.allProduct!.data![index].image != null
                                          ?Image.network(
                                              '${widget.allProduct!.data![index].image}',fit: BoxFit.fill)
                                          :Image.asset(
                                              'assets/images/noimage.jpg',fit: BoxFit.fill,),
                                        )),
                                        DataCell(
                                            Center(child: Text('${widget.allProduct!.data![index].cost}'))),
                                        DataCell(
                                            Center(child: Text('${widget.allProduct!.data![index].price_for_retail}'))),
                                        DataCell(
                                            Center(child: Text('${widget.allProduct!.data![index].price_for_wholesale}'))),
                                        DataCell(
                                            Center(child: Text('${widget.allProduct!.data![index].price_for_box}'))),
                                        DataCell(
                                            Center(child: Text('${widget.allProduct!.data![index].remain}'))),
                                      ],
                                      selected: selected[index],
                                      onSelectChanged: (bool? value) {
                                        setState(() {
                                          selected[index] = value!;
                                          if (widget.selectProducts != null) {
                                            widget.selectProducts!.add(widget.allProduct!.data![index]);
                                            newSelectProducts = widget.selectProducts!;
                                          } else {
                                            newSelectProducts.add(widget.allProduct!.data![index]);
                                          }
                                          
                                        });
                                      },
                                    ))):SizedBox(),
                      ),
                    ],
                  ),
                ),
              ):SizedBox(),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GestureDetector(
                  onTap: ()async{
                    Navigator.pop(context, newSelectProducts);
                  },
                  child: Container(
                    width: size.width * 0.1,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kPrimaryColor),
                    child: Center(
                      child: Text(
                        'เลือก',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
