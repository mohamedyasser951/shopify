import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/cart/data/models/card_model.dart';
import 'package:commerceapp/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:commerceapp/features/cart/presentation/widgets/cart_widget.dart';
import 'package:commerceapp/generated/l10n.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).card),
      ),
      body: BlocConsumer<CartBloc, CartState>(listener: (context, state) {
        if (state is CartLoaddedState) {
          
        }
      }, builder: (context, state) {
        if (state is CartInitial) {
          return LoadingWidget();
        } else if (state is CartLoaddedState) {
          if (state.cartdata.cartItems!.isEmpty) {
            return Center(
              child: Text("Your cart is Empty.",style: Theme.of(context).textTheme.bodyLarge,),
            );
          }
          return CartBuilder(
            cartmodel: state.cartdata,
          );
        } else if (state is CartErrorState) {
          return Text(state.error);
        }
        return Container(
          color: Colors.amber,
        );
      }),
    );
  }
}

class CartBuilder extends StatelessWidget {
  final CardData cartmodel;
  const CartBuilder({
    Key? key,
    required this.cartmodel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartmodel.cartItems!.length,
            itemBuilder: (context, index) =>
                CardWidget(cartItems: cartmodel.cartItems![index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          ),
          CardBottom(total: cartmodel.total!),
        ],
      ),
    );
  }
}
