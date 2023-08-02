import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_sp2/core/data/models/apis/category_model.dart';
import 'package:food_ordering_sp2/core/data/models/apis/token_info.dart';
import 'package:food_ordering_sp2/core/data/models/common_response.dart';
import 'package:food_ordering_sp2/core/data/network/endpoints/category_endpoints.dart';
import 'package:food_ordering_sp2/core/data/network/endpoints/user_endpoints.dart';
import 'package:food_ordering_sp2/core/data/network/network_config.dart';
import 'package:food_ordering_sp2/core/enums/request_type.dart';
import 'package:food_ordering_sp2/core/utils/network_util.dart';

class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndpoints.getall,
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<CategoryModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(CategoryModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
