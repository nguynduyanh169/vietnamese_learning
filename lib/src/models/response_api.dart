import 'package:hive/hive.dart';
part 'response_api.g.dart';

@HiveType(typeId: 0)
class ResponseAPI{
  @HiveField(0)
  String name;

  @HiveField(1)
  String response;

  ResponseAPI({this.name, this.response});
}