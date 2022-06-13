import 'package:flutter/material.dart';
import 'package:technician_app/src/controller/service_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/service_model.dart';
import 'package:technician_app/src/view/widgets/auth_button.dart';
import 'package:technician_app/src/view/widgets/auth_textfield.dart';

import '../../../style/custom_style.dart';

class ServicesCreatePage extends StatefulWidget {
  const ServicesCreatePage({Key? key}) : super(key: key);
  static const routeName = '/home/services/create';
  @override
  State<ServicesCreatePage> createState() => _ServicesCreatePageState();
}

class _ServicesCreatePageState extends State<ServicesCreatePage> {
  final serviceNameController = TextEditingController();
  final servicePriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                AuthTextField(textEditingController: serviceNameController),
                AuthTextField(textEditingController: servicePriceController),
                const SizedBox(
                  height: 48,
                ),
                AuthButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var service = Service(
                            id: '',
                            name: serviceNameController.text,
                            price: double.parse(servicePriceController.text),
                            isActive: true);
                        await ServiceController()
                            .create(service)
                            .then((value) => Navigator.of(context).pop())
                            .catchError((e) {
                          logError('Error create services');
                          //TODO: Show error dialog
                        });
                      }
                    },
                    color: CustomStyle.primarycolor,
                    child: const Text('Create'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
