import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerceapp/Config/components/loading.dart';
import 'package:commerceapp/Config/components/skelton.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    var settingBloc = BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: CachedNetworkImage(
                      width: 30,
                      height: 30,
                      imageUrl: settingBloc.userProfileData!.image!,
                      placeholder: (context, url) => const Loadingitem(
                          widget: Skeleton(
                        width: 30,
                        height: 30,
                      )),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        settingBloc.userProfileData!.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        settingBloc.userProfileData!.email!,
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
                'Shipping addresse',
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
    );
  }
}
