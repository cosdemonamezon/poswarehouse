import 'package:json_annotation/json_annotation.dart';
import 'package:poswarehouse/models/product.dart';
import 'package:poswarehouse/models/receivinggoods.dart';

part 'receiving.g.dart';

@JsonSerializable()
class Receiving {
  final int? id;
  final String? stock_pick_out_no;
  final String? pick_out_date;
  final String? status;
  final String? created_at;
  final String? updated_at;
  final String? create_by;
  final String? update_by;
  final int? No;
  final List<ReceivingGoods>? pick_out_lines;
  

  Receiving(    
    this.id,
    this.stock_pick_out_no,
    this.pick_out_date,
    this.status,
    this.created_at,
    this.updated_at,
    this.create_by,
    this.update_by,
    this.No,
    this.pick_out_lines
  );

  factory Receiving.fromJson(Map<String, dynamic> json) => _$ReceivingFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivingToJson(this);
}
