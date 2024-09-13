import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/features/settings/presentation/pages/Profile/orders/data/models/orders_details_model.dart';
import 'package:commerceapp/features/home/features/settings/presentation/pages/Profile/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsPage extends StatefulWidget {
  final int orderId;
  const OrderDetailsPage({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context)
        .add(GetOrdersDetailsEvent(id: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is GetOrderDetailLoadingState) {
            return const LoadingWidget();
          } else if (state is GetOrderDetailErrorState) {
            return Center(child: Text(state.message));
          } else if (state is GetOrderDetailSuccessState) {
            return OrderDetailsBody(
                ordersDetailsData: state.ordersDetailsModel.data!);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    super.key,
    required this.ordersDetailsData,
  });

  final OrdersDetailsData ordersDetailsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("order: ${ordersDetailsData.id}"),
              Text(
                ordersDetailsData.date!,
                style: TextStyle(color: AppColors.grayColor, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("points commission: ${ordersDetailsData.pointsCommission}"),
              Text(
                ordersDetailsData.status!,
                style: TextStyle(
                                      fontSize: 16,

                    color: ordersDetailsData.status! == "New" ||
                            ordersDetailsData.status! == "جديد"
                        ? Colors.green
                        : Colors.red),
              ),
            ],
          ),
          Container(
            height: 300,
          ),
          Text(
            "order information",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.grayColor, fontSize: 18),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Shipping Address:"),
              Text(ordersDetailsData.address!.city!)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Payment method:"),
              Text(ordersDetailsData.paymentMethod!)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount:"),
              Text(ordersDetailsData.total!.toString())
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text("Reorder")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {},
                  child: const Text(
                    "Leave feedback",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
