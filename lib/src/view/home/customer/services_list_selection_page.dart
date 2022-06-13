import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/service_controller.dart';
import '../../../model/service_model.dart';
import '../../../provider/root_provider.dart';
import '../../../style/custom_style.dart';

class ServiceListPageSelection extends StatefulWidget {
  const ServiceListPageSelection({Key? key}) : super(key: key);
  static const routeName = '/index/createbooking/services';

  @override
  State<ServiceListPageSelection> createState() =>
      _ServiceListPageSelectionState();
}

class _ServiceListPageSelectionState extends State<ServiceListPageSelection> {
  final serviceController = ServiceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 120, 32, 64),
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
            StreamBuilder<List<Service>>(
                stream: serviceController.read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: CustomStyle.primarycolor,
                    );
                  } else {
                    if (snapshot.hasData) {
                      var services = snapshot.data!;
                      return ListServices(services: services);
                    } else {
                      return Text(
                          'Error getting services has error ${snapshot.hasError}');
                    }
                  }
                })
          ],
        ),
      )),
    );
  }
}

class ListServices extends StatefulWidget {
  const ListServices({Key? key, required this.services}) : super(key: key);
  final List<Service> services;
  @override
  State<ListServices> createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServices> {
  @override
  void initState() {
    var rootProvider = context.read<RootProvider>();
    if (rootProvider.services.isNotEmpty) {
      for (var i = 0; i < rootProvider.services.length; i++) {
        var index = widget.services
            .indexWhere((element) => rootProvider.services[i].id == element.id);

        if (index != -1) {
          widget.services[i].selected = true;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    var rootProvider = context.read<RootProvider>();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.services.length,
        itemBuilder: (context, i) {
          return Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: widget.services[i].selected,
                onChanged: (bool? value) {
                  setState(() {
                    widget.services[i].selected = value!;
                  });

                  if (value == null) {
                    return;
                  }
                  if (value) {
                    try {
                      var serviceObj = rootProvider.services.firstWhere(
                          (element) => element.id == widget.services[i].id);
                    } on StateError {
                      rootProvider.addService = widget.services[i];
                    }
                  } else {
                    try {
                      var serviceObj = rootProvider.services.firstWhere(
                          (element) => element.id == widget.services[i].id);
                      rootProvider.removeService = serviceObj.id;
                    } on StateError {}
                  }
                  //
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.services[i].name),
                  Text('RM ${widget.services[i].price.toString()}'),
                ],
              ),
            ],
          );
        });
  }
}
