import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).profile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mohamed yasser"),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Mohamedhcjdiv@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grayColor),
                    )
                  ],
                )
              ],
            ),
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
