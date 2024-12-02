import '../Models/productmodel.dart';

class ProductViewmodel {
  final ProductModel data;
  ProductViewmodel({required this.data});
  int? get id {
    return data.id;
  }

  String? get productname1 {
    return data.productname;
  }

  String? get image {
    return data.image;
  }

  double? get price {
    return data.price;
  }
}
