import 'package:flutter/material.dart';

import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/features/settings/presentation/pages/Profile/orders/data/models/orders_model.dart';

class OrderItem extends StatelessWidget {
  final OrderData orderData;
  const OrderItem({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("order: ${orderData.id}"),
                Text(
                  orderData.date!,
                  style: TextStyle(color: AppColors.grayColor, fontSize: 16),
                ),
              ],
            ),
            Text(
              "Total Amount : ${orderData.total}\$",
              style: TextStyle(color: AppColors.grayColor, fontSize: 16),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {},
                    child: const Text("Details")),
                Text(orderData.status!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
