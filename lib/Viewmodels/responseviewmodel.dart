import '../Models/responsemodel.dart';

class ResponseViewmodel {
  final ResponseModel data;

  ResponseViewmodel({required this.data});
  String? get msg {
    return data.msg;
  }
}
