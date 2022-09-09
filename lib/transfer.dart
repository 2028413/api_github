import 'package:json_annotation/json_annotation.dart';


part 'transfer.g.dart';

@JsonSerializable()
class Truc{
  Truc();

  String name = '';
  bool private = false;

  factory Truc.fromJson(Map<String, dynamic> json) => _$TrucFromJson(json);
  Map<String, dynamic> toJson() => _$TrucToJson(this);
}