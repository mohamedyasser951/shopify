import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/home/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(GetCardEvent());
    var cardModel = BlocProvider.of<CartBloc>(context).cartModel;

    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).card),
        ),
        body: Builder(builder: (
          context,
        ) {
          if (state is GetCardSErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          if (state is GetCardLoadingState) {
            return const LoadingWidget();
          } else  {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cardModel!.data!.cartItems!.length,
                    itemBuilder: (context, index) => CardWidget(
                        cartItems: cardModel.data!.cartItems![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                  ),
                  CardBottom(total: BlocProvider.of<CartBloc>(context).total!),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      );
    });
  }
}

class CardWidget extends StatelessWidget {
  final CartItems cartItems;
  const CardWidget({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CachedNetworkImage(
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    imageUrl: cartItems.product!.image!,
                    placeholder: (context, url) => const Loadingitem(
                        widget: Skeleton(
                      width: 100,
                      height: 100,
                    )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cartItems.product!.name!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${cartItems.product!.price}\$",
                              style: TextStyle(
                                  color: AppColors.primaryColor, fontSize: 16),
                            ),
                            QuantityComponents(quantity: cartItems.quantity!, productId: cartItems.id!,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<CartBloc>(context)
                  .add(DeleteCartEvent(productId: cartItems.id!));
            },
            child: const CircleAvatar(
                radius: 12.0,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.delete,
                  size: 12,
                )),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class QuantityComponents extends StatefulWidget {
  num quantity;
  int productId;
  QuantityComponents({
    Key? key,
    required this.quantity,
    required this.productId,
  }) : super(key: key);

  @override
  State<QuantityComponents> createState() => _QuantityComponentsState();
}

class _QuantityComponentsState extends State<QuantityComponents> {
  @override
  Widget build(BuildContext context) {
    void increment() {
      setState(() {
        widget.quantity++;
         BlocProvider.of<CartBloc>(context).add(UpdateCartEvent(
              productId: widget.productId, quantity: widget.quantity.toInt()));
      });
    }

    void decrement() {
      setState(() {
        if (widget.quantity >= 0) {
          widget.quantity -= 1;
          BlocProvider.of<CartBloc>(context).add(UpdateCartEvent(
              productId: widget.productId, quantity: widget.quantity.toInt()));
        }
      });
    }

    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                increment();
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.primaryColor),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            Text(widget.quantity.toString()),
            ElevatedButton(
              onPressed: () {
                decrement();
              },
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: AppColors.grayColor),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CardBottom extends StatelessWidget {
  final int total;
  const CardBottom({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total amount:"),
              Text("$total\$"),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomButton(
              widget: const Text(
                "check out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
