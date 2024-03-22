import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerceapp/Config/Extensions/validator_extenstion.dart';
import 'package:commerceapp/Config/components/dialogs.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/settings/data/models/addresses_data.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';

class AddOrUpdateAddressesPage extends StatelessWidget {
  const AddOrUpdateAddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adding Shipping Address"),
        centerTitle: true,
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is AddAdresessSucessState) {
            if (state.addressesModel.status == true) {
              CustomDialog.animatedDialog(
                  title: state.addressesModel.message!,
                  description: "",
                  context: context,
                  isError: false);
            } else {
              CustomDialog.animatedDialog(
                  title: state.addressesModel.message!,
                  description: "",
                  context: context,
                  isError: true);
            }
          } else if (state is AddAdresessErrorState) {
            CustomDialog.animatedDialog(
                title: state.error,
                description: "",
                context: context,
                isError: true);
          }
        },
        child: SingleChildScrollView(
            child: AddOrUpdateAdresssForm(
          isUpdateAddresses: false,
        )),
      ),
    );
  }
}

class AddOrUpdateAdresssForm extends StatefulWidget {
 final bool isUpdateAddresses;
  final AddressData? addressData;
  const AddOrUpdateAdresssForm({
    Key? key,
    required this.isUpdateAddresses,
    this.addressData,
  }) : super(key: key);

  @override
  State<AddOrUpdateAdresssForm> createState() => _AddOrUpdateAdresssFormState();
}

class _AddOrUpdateAdresssFormState extends State<AddOrUpdateAdresssForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController regionController = TextEditingController();

  final TextEditingController detailsController = TextEditingController();

  final TextEditingController notesController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    if (widget.isUpdateAddresses) {
      nameController.text = widget.addressData!.name!;
      addressController.text = widget.addressData!.city!;
      detailsController.text = widget.addressData!.details!;
      regionController.text = widget.addressData!.region!;
      cityController.text = widget.addressData!.city!;
      notesController.text = widget.addressData!.notes!;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    regionController.dispose();
    detailsController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            CustomeTextField(
              textEditingController: nameController,
              hintText: "Full Name",
              validator: (val) {
                if (val!.isEmpty) {
                  return "Name Required";
                }
                if (val.isValidName) {
                  return "Please enter valid Name";
                }
                return null;
              },
            ),
            CustomeTextField(
              textEditingController: addressController,
              hintText: "Addresse",
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter valid Addresse";
                }
                return null;
              },
            ),
            CustomeTextField(
              textEditingController: cityController,
              hintText: "City",
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter valid City Name";
                }
                return null;
              },
            ),
            CustomeTextField(
              textEditingController: detailsController,
              hintText: "Details Addresse",
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter Details Addresse";
                }
                return null;
              },
            ),
            CustomeTextField(
              textEditingController: regionController,
              hintText: "State/Province/Region",
              validator: (val) {
                if (val!.isEmpty) {
                  return "Please enter valid  Region";
                }
                return null;
              },
            ),
            CustomeTextField(
              textEditingController: notesController,
              hintText: "Notes",
              validator: (val) {
                return null;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return CustomButton(
                    widget: state is AddAdresessLoadingState
                        ? const LoadingWidget()
                        : const Text(
                            "Add Address",
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: validate_and_add);
              },
            ),
          ],
        ),
      ),
    );
  }

  void validate_and_add() {
    if (formkey.currentState!.validate()) {
      AddressData addressData = AddressData(
        name: nameController.text.trim(),
        city: cityController.text.trim(),
        details: detailsController.text.trim(),
        notes: notesController.text.trim(),
        region: regionController.text.trim(),
        latitude: 30.0616863,
        longitude: 31.3260088,
      );
      BlocProvider.of<SettingsBloc>(context)
          .add(AddAddresessEvent(addressData: addressData));
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
