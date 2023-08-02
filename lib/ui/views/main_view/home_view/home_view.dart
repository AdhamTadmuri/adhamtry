import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_ordering_sp2/core/data/models/apis/category_model.dart';
import 'package:food_ordering_sp2/core/data/models/apis/meal_model.dart';
import 'package:food_ordering_sp2/core/data/repositories/category_repository.dart';
import 'package:food_ordering_sp2/core/data/repositories/meal_repository.dart';
import 'package:food_ordering_sp2/core/enums/message_type.dart';
import 'package:food_ordering_sp2/core/enums/operation_type.dart';
import 'package:food_ordering_sp2/core/enums/request_status.dart';
import 'package:food_ordering_sp2/ui/shared/colors.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_ordering_sp2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_ordering_sp2/ui/shared/utils.dart';
import 'package:food_ordering_sp2/ui/views/main_view/home_view/home_controller.dart';
import 'package:food_ordering_sp2/ui/views/meal_details_view/meal_details_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeView extends StatefulWidget {
  final Function onPressed;
  HomeView({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          drawer: Container(
            color: AppColors.mainRedColor,
          ),
          body: Column(
            children: [
              Icon(
                Icons.wifi,
                color: Colors.green,
                size: 70,
              ),
              Obx(() {
                return controller.isCategoryLoading
                    ? SpinKitCircle(
                        color: AppColors.mainOrangeColor,
                      )
                    : Expanded(
                        child: controller.categoryList.isEmpty
                            ? Text('No Category')
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: controller.categoryList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'http://via.placeholder.com/350x150',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Text(
                                        controller.categoryList[index].name ??
                                            '',
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      );
              }),
              Obx(() {
                return controller.isMealLoading
                    ? SpinKitCircle(
                        color: AppColors.mainOrangeColor,
                      )
                    : Expanded(
                        child: controller.mealList.isEmpty
                            ? Text('No Meal')
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: controller.mealList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            await Get.to(MealDetailsView(
                                                model: controller
                                                    .mealList[index]));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'http://via.placeholder.com/350x150',
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )),
                                      Row(
                                        children: [
                                          Text(
                                            controller.mealList[index].name ??
                                                '',
                                            style: TextStyle(fontSize: 50),
                                          ),
                                          CustomButton(
                                            text: '+',
                                            textSize: screenWidth(10),
                                            onPressed: () {
                                              controller.addToCart(
                                                  controller.mealList[index]);
                                            },
                                          ),
                                          Obx(() {
                                            print(
                                                controller.categoryList.length);
                                            return CustomButton(
                                              text: '${cartService.cartCount}',
                                              textSize: screenWidth(10),
                                              onPressed: () {},
                                            );
                                          })
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                      );
              })
            ],
          )),
    );
  }
}
