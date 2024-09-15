import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/features/home/presentation/pages/search_page.dart';
import 'package:commerceapp/features/home/presentation/widgets/home_body.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/home/presentation/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).home),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchPage());
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          // if (state is SetOrDeleteErrorState) {
          //   customToast(mesg: state.error, color: Colors.red);
          // }
          // if (state is SetOrDeleteSuccessState) {
          //   customToast(mesg: state.successMessage);
          // }
        }, builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return LoadingWidget();
            case Status.error:
              return ErrorItem(errorMessage: state.errorMessage);
            case Status.success:
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: HomeBody(homeModel: cubit.homeModel!),
                ),
              );
          }
          // switch (state) {
          //   case GetHomeDataErrorState():
          //     return ErrorItem(errorMessage: state.error);
          //   default:
          //     return cubit.homeModel != null
          //         ? SingleChildScrollView(
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //               child: HomeBody(homeModel: cubit.homeModel!),
          //             ),
          //           )
          //         : LoadingWidget();
          // }
        }));
  }
}
