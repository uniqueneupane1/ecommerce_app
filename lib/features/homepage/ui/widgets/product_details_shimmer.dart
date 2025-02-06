import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Shimmer(
              duration: Duration(seconds: 2),
              color: Colors.black,
              colorOpacity: 0.1,
              enabled: true,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .35,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Shimmer(
              duration: Duration(seconds: 2),
              color: Colors.black,
              colorOpacity: 0.1,
              enabled: true,
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  color: Colors.black,
                  colorOpacity: 0.1,
                  enabled: true,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  color: Colors.black,
                  colorOpacity: 0.1,
                  enabled: true,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...List.generate(
            8,
            (index) {
              return Container(
                padding: EdgeInsets.only(bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Shimmer(
                    duration: Duration(seconds: 2),
                    color: Colors.black,
                    colorOpacity: 0.1,
                    enabled: true,
                    child: Container(
                      height: 16,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
