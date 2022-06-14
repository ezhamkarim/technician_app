import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/service_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

import '../../../helper/dialog_helper.dart';
import '../../../style/custom_style.dart';

class ServicesCreatePage extends StatefulWidget {
  const ServicesCreatePage({Key? key, this.service}) : super(key: key);
  static const routeName = '/index/services/create';
  final Service? service;
  @override
  State<ServicesCreatePage> createState() => _ServicesCreatePageState();
}

class _ServicesCreatePageState extends State<ServicesCreatePage> {
  final serviceNameController = TextEditingController();
  final servicePriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.service != null) {
      serviceNameController.text = widget.service!.name;
      servicePriceController.text = widget.service!.price.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rootProvider = context.watch<RootProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Services.',
                      style: CustomStyle.getStyle(
                          Colors.black, FontSizeEnum.title, FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                AuthTextField(
                  textEditingController: serviceNameController,
                  placeholder: 'Name',
                ),
                const SizedBox(
                  height: 48,
                ),
                AuthTextField(
                    textEditingController: servicePriceController,
                    placeholder: 'Price'),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AuthButton(
                          viewState: rootProvider.viewState,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (widget.service != null) {
                                var service = Service(
                                    id: widget.service!.id,
                                    name: serviceNameController.text,
                                    price: double.parse(
                                        servicePriceController.text),
                                    isActive: true);
                                await ServiceController()
                                    .update(service, rootProvider)
                                    .then(
                                        (value) => Navigator.of(context).pop())
                                    .catchError((e) {
                                  logError('Error create services');
                                  DialogHelper.dialogWithOutActionWarning(
                                      context, e.toString());
                                });
                              } else {
                                var service = Service(
                                    id: '',
                                    name: serviceNameController.text,
                                    price: double.parse(
                                        servicePriceController.text),
                                    isActive: true);
                                await ServiceController()
                                    .create(service, rootProvider)
                                    .then(
                                        (value) => Navigator.of(context).pop())
                                    .catchError((e) {
                                  logError('Error create services');
                                  DialogHelper.dialogWithOutActionWarning(
                                      context, e.toString());
                                });
                              }
                            }
                          },
                          color: CustomStyle.primarycolor,
                          child: Text(
                              widget.service == null ? 'Create' : 'Update')),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
