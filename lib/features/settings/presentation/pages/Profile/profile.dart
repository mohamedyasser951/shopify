import 'package:commerceapp/Config/components/cachedNetworkImage.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/error_widget.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    SettingsBloc settingBloc = BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                if (state is GetProfileLoadingState) {
                  return const LoadingWidget();
                }
                if (state is GetAdresessErrorState) {
                  return ErrorItem(
                    errorMessage: state.error,
                  );
                }
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: settingBloc.userProfileData?.image != null
                          ? CashedNetworkImage(
                              width: 30,
                              height: 30,
                              imgUrl: settingBloc.userProfileData!.image!)
                          : null,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          settingBloc.userProfileData?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          settingBloc.userProfileData?.email ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.grayColor),
                        )
                      ],
                    )
                  ],
                );
              }),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, "/ordersPage"),
                title: Text(
                  S.of(context).orders,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  S.of(context).already_have_orders,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(
                height: 6,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/adressesPage");
                },
                title: Text(
                  "shipping addresse",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  S.of(context).adresses,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(
                height: 6,
              ),
              ListTile(
                title: Text(
                  S.of(context).payment_methods,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  S.of(context).Visea,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const SizedBox(
                height: 6,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/settings");
                },
                title: Text(
                  S.of(context).settings,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  S.of(context).Language_password,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
