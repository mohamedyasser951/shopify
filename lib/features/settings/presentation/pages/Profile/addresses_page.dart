import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:commerceapp/features/settings/data/models/addresses_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdressesPage extends StatefulWidget {
  const AdressesPage({super.key});

  @override
  State<AdressesPage> createState() => _AdressesPageState();
}

class _AdressesPageState extends State<AdressesPage> {
  @override
  void initState() {
    if (BlocProvider.of<SettingsBloc>(context).userAddresess?.data == null) {
      BlocProvider.of<SettingsBloc>(context).add(GetAddresessEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipping Addresses"),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is GetAdresessErrorState) {
            return Text(state.error);
          }
          return state is GetAdresessLoadingState
              ? const LoadingWidget()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListView.separated(
                    itemCount: 1,
                    itemBuilder: (context, index) => AddressItem(
                        addressData: BlocProvider.of<SettingsBloc>(context)
                            .userAddresess!
                            .data![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 6.0,
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddressItem extends StatefulWidget {
  final AddressData addressData;
  const AddressItem({
    Key? key,
    required this.addressData,
  }) : super(key: key);

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
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
                Text(widget.addressData.name!),
                TextButton(onPressed: () {}, child: const Text("Edit"))
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text('${widget.addressData.city!}, ${widget.addressData.region!}'),
            Text(widget.addressData.details!),
            Row(
              children: [
                Checkbox.adaptive(
                  value: true,
                  onChanged: (value) {},
                ),
                const Text("Use as the shipping address")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
