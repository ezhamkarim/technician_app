import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technician_app/src/controller/user_controller.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';

import '../../../style/custom_style.dart';

class TechnicianListPage extends StatefulWidget {
  const TechnicianListPage({Key? key}) : super(key: key);
  static const routeName = '/index/createbooking/technician';
  @override
  State<TechnicianListPage> createState() => _TechnicianListPageState();
}

class _TechnicianListPageState extends State<TechnicianListPage> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
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
                  'Technician List.',
                  style: CustomStyle.getStyle(
                      Colors.black, FontSizeEnum.title, FontWeight.bold),
                ),
              ],
            ),
            StreamBuilder<List<UserModel>>(
                stream: UserController(firebaseUser.uid).readTechnician(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: CustomStyle.primarycolor,
                    );
                  } else {
                    if (snapshot.hasData) {
                      var technician = snapshot.data!;
                      return ListTechnician(technician: technician);
                    } else {
                      return Text(
                          'Error getting feedback has error ${snapshot.hasError}. Error ${snapshot.error}');
                    }
                  }
                })
          ],
        ),
      )),
    );
  }
}

class ListTechnician extends StatefulWidget {
  const ListTechnician({Key? key, required this.technician}) : super(key: key);
  final List<UserModel> technician;
  @override
  State<ListTechnician> createState() => _ListTechnicianState();
}

class _ListTechnicianState extends State<ListTechnician> {
  String? technicianSelected;

  @override
  void initState() {
    var rootProvider = context.read<RootProvider>();
    if (rootProvider.technician != null) {
      technicianSelected = rootProvider.technician!.email;
      // logSuccess('Technician ${technicianSelected!.name}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rootProvider = context.read<RootProvider>();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.technician.length,
        itemBuilder: (context, i) {
          return Row(
            children: [
              Radio<String>(
                  value: widget.technician[i].email,
                  groupValue: technicianSelected,
                  onChanged: (tech) {
                    setState(() {
                      technicianSelected = tech;
                    });
                    rootProvider.setTechnician = widget.technician
                        .firstWhere((element) => tech == element.email);
                  }),
              Text(widget.technician[i].name)
            ],
          );
        });
  }
}
