import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/themes/constant.dart';

class SettingShimmer extends StatelessWidget {
  const SettingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Shimmer.fromColors(
                  baseColor: AppColor.baseShimmer,
                  highlightColor: AppColor.highlightShimmer,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.lightText,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: AppColor.baseShimmer,
                  highlightColor: AppColor.highlightShimmer,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.lightText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Shimmer.fromColors(
          baseColor: AppColor.baseShimmer,
          highlightColor: AppColor.highlightShimmer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 25,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.lightText,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColor.baseShimmer,
                    highlightColor: AppColor.highlightShimmer,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightText,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColor.baseShimmer,
                        highlightColor: AppColor.highlightShimmer,
                        child: Container(
                          height: 20,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.lightText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Shimmer.fromColors(
                        baseColor: AppColor.baseShimmer,
                        highlightColor: AppColor.highlightShimmer,
                        child: Container(
                          height: 15,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.lightText,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
