import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:food_ordering_sp2/core/data/models/apis/token_info.dart';
import 'package:food_ordering_sp2/core/data/models/common_response.dart';
import 'package:food_ordering_sp2/core/data/network/endpoints/user_endpoints.dart';
import 'package:food_ordering_sp2/core/data/network/network_config.dart';
import 'package:food_ordering_sp2/core/enums/request_type.dart';
import 'package:food_ordering_sp2/core/utils/network_util.dart';

class UserRepository {
  Future<Either<String, TokenInfo>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.login,
        body: {
          'userName': email,
          'password': password,
        },
        headers: NetworkConfig.getHeaders(
            needAuth: false, extraHeaders: {"Language": "ar"}),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> register({
    required String firstname,
    required String lastname,
    required String photoPath,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        url: UserEndpoints.register,
        fields: {
          'FirstName': firstname,
          'LastName': lastname,
        },
        files: {"Images": photoPath},
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
