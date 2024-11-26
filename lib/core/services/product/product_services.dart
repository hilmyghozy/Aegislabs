import 'package:aegislabs/core/models/carts/carts_model.dart';
import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:aegislabs/core/http/dio_client.dart';
import 'package:aegislabs/core/models/base_reponse/base_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/http.dart';

part 'product_services.g.dart';

@RestApi()
abstract class ProductService {
  factory ProductService() {
    String baseUrl = dotenv.env["BASE_URL"]!;
    return _ProductService(DioClient().dio, baseUrl: baseUrl.trim());
  }

  @GET("/products")
  Future<List<Products?>> products();

  @GET("/products/{productId}")
  Future<Products?> productsDetail(
    @Path() int productId,
  );

  @GET("/products/categories")
  Future<List<String?>> getCategories();

  @GET("/products/category/{categories}")
  Future<List<Products?>> getSpecificCategories(
    @Path() String categories,
  );

  @GET("/carts/user/1")
  Future<List<CartsModel?>> getCarts();

  @POST("/carts")
  Future<dynamic> addCarts(
    @Body() Map<String, dynamic> payload,
  );

  @DELETE("/carts/{id}")
  Future<dynamic> deleteCarts(
    @Path() int id,
  );
}
