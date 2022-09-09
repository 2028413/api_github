
part of 'transfer.dart';


Truc _$TrucFromJson(Map<String, dynamic> json){
  return Truc()
      ..name = json['name'] as String
      ..private = json['private'] as bool;
}

Map<String, dynamic> _$TrucToJson(Truc instance) => <String, dynamic>{
  'name': instance.name,
  'private': instance.private,
};