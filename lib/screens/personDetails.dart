import 'package:flutter/material.dart';
import 'package:staff_app/models/staffDetails.dart';
import 'package:staff_app/services/commonFunctions.dart';
import 'package:staff_app/utils/customWidgets.dart';

class PersonDetailsScreen extends StatefulWidget {
  final StaffDetails onePerson;
  const PersonDetailsScreen({Key? key, required this.onePerson})
      : super(key: key);

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              verticalSpace(customHeight * 0.1),
              CircleAvatar(
                radius: 100,
                backgroundImage:
                    imageFromBase64String(widget.onePerson.imageDp),
              ),
              verticalSpace(customHeight * 0.02),
              Text(
                widget.onePerson.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(customHeight * 0.05),
              Text(
                'Age: ${widget.onePerson.age}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              verticalSpace(customHeight * 0.01),
              Text(
                'Mobile: ${widget.onePerson.phone}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              verticalSpace(customHeight * 0.01),
              Text(
                'Department: ${widget.onePerson.department}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
