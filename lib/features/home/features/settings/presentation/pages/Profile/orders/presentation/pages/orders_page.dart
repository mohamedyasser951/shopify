import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/features/settings/presentation/pages/Profile/orders/presentation/bloc/orders_bloc.dart';
import 'package:commerceapp/features/home/features/settings/presentation/pages/Profile/orders/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrdersBloc ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Orders"),
          centerTitle: true,
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is GetAllOrdersErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            return ordersBloc.ordersModel?.data == null
                ? const LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.separated(
                      itemCount: ordersBloc.ordersModel!.data!.data!.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 4.0,
                      ),
                      itemBuilder: (context, index) => OrderItem(
                          orderData:
                              ordersBloc.ordersModel!.data!.data![index]),
                    ),
                  );
          },
        ));
  }
}
