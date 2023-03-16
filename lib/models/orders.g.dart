// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orders _$OrdersFromJson(Map<String, dynamic> json) => Orders(
      json['current_page'] as int,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['first_page_url'] as String?,
      json['from'] as int?,
      json['last_page'] as int?,
      json['last_page_url'] as String?,
      json['next_page_url'] as String?,
      json['per_page'] as int?,
      json['to'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$OrdersToJson(Orders instance) => <String, dynamic>{
      'current_page': instance.current_page,
      'data': instance.data,
      'first_page_url': instance.first_page_url,
      'from': instance.from,
      'last_page': instance.last_page,
      'last_page_url': instance.last_page_url,
      'next_page_url': instance.next_page_url,
      'per_page': instance.per_page,
      'to': instance.to,
      'total': instance.total,
    };
