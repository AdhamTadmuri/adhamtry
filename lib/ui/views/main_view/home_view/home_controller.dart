 import 'package:food_ordering_sp2/core/data/models/apis/category_model.dart';
import 'package:food_ordering_sp2/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp2/core/data/repositories/category_repository.dart';
import 'package:food_ordering_sp2/core/data/repositories/meal_repository.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/core/enums/operation_type.dart';
import 'package:food_ordering_sp2/core/enums/request_status.dart';
import 'package:food_ordering_sp2/core/services/base_controller.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<MealModel> mealList = <MealModel>[].obs;

  bool get isCategoryLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      operationType.contains(OperationType.CATEGORY);

  bool get isMealLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      operationType.contains(OperationType.MEAL);


  @override
  void onInit() async {
    await getAllGategory();
    await getAllMeal();

    super.onInit();
  }

  Future<void> getAllGategory() async {
    await runLoadingFutureFunction(
        type: OperationType.CATEGORY,
        function: CategoryRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMeassge(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            categoryList.addAll(r);
          });
        }));
  }

  Future<void> getAllMeal() async {
    await runLoadingFutureFunction(
        type: OperationType.MEAL,
        function: MealRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMeassge(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            mealList.addAll(r);
          });
        }));
  }

  void addToCart(MealModel model) {
    cartService.addToCart(
        model: model,
        count: 1,
        afterAdd: () {

          CustomToast.showMeassge(
              message: 'Added', messageType: MessageType.SUCCSESS);
        });
  }
}
