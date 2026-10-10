import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localmarket/shopkeeper/home/add_product/model/add_product_model.dart';

class ProductRepository {
  final FirebaseFirestore _db;

  ProductRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  ProductModel _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> d) {
    final data = d.data();
    data['productId'] = d.id;
    return ProductModel.fromMap(data);
  }

  Stream<List<ProductModel>> watchProducts() {
    return _db
        .collection('products')
        .snapshots()
        .map((snap) => snap.docs.map(_fromDoc).toList());
  }

  Future<List<ProductModel>> fetchProducts() async {
    final snap = await _db.collection('products').get();
    return snap.docs.map(_fromDoc).toList();
  }
}