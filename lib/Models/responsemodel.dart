class ResponseModel {
  String? msg;

  ResponseModel({required this.msg});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      msg: json["msg"] ?? "Unknown", // Default to "Unknown" if msg is null
    );
  }
}
