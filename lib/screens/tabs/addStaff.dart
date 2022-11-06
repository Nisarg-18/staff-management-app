import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staff_app/services/mongodb.dart';
import 'package:staff_app/utils/customWidgets.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({Key? key}) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final _picker = ImagePicker();
  File? _displayImage;
  var base64Image;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? dropDownDepartment;
  List dept = [
    'HR',
    'Finance',
    'Housekeeping',
    'Marketing',
  ];
  static const deptSnackBar = SnackBar(
    content: Text('Please select a department'),
  );
  static const imageSnackBar = SnackBar(
    content: Text('Please upload an image'),
  );
  static const successSnackBar = SnackBar(
    content: Text('Added Successfully'),
  );

  Future openCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _displayImage = File(image.path);
      }
    });
    final bytes = _displayImage!.readAsBytesSync();
    base64Image = "data:image/png;base64," + base64Encode(bytes);
  }

  Future openGallery() async {
    var picture = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        _displayImage = File(picture.path);
      }
    });
    final bytes = _displayImage!.readAsBytesSync();
    base64Image = "data:image/png;base64," + base64Encode(bytes);
  }

  _selectImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Open Camera',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onTap: () async {
                      await openCamera();
                      Navigator.pop(context);
                    },
                  ),
                  Divider(
                    height: 20.0,
                    color: Colors.black,
                    thickness: 2.0,
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Open Gallery',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onTap: () async {
                      await openGallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        verticalSpace(customHeight * 0.1),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.2),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                          ),
                          validator: RequiredValidator(
                              errorText: 'please enter your name'),
                        ),
                        verticalSpace(customHeight * 0.02),
                        TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          maxLength: 3,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Age',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.2),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                          ),
                          validator: RequiredValidator(
                              errorText: 'please enter your age'),
                        ),
                        verticalSpace(customHeight * 0.02),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          maxLength: 10,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Phone',
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.2),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'please enter phone number'),
                            MinLengthValidator(10,
                                errorText: 'please enter valid phone number'),
                          ]),
                        ),
                        verticalSpace(customHeight * 0.02),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              // vertical: 15,
                              horizontal: 20,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          hint: const Text("Department"),
                          value: dropDownDepartment,
                          items: dept.map((d) {
                            return DropdownMenuItem(value: d, child: Text(d));
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              dropDownDepartment = val.toString();
                            });
                          },
                        ),
                        verticalSpace(customHeight * 0.02),
                        _displayImage == null
                            ? ElevatedButton(
                                onPressed: () async {
                                  await _selectImage(context);
                                },
                                child: const Text('Upload Photo'),
                              )
                            : Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _displayImage = null;
                                      });
                                    },
                                    child: const Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 40,
                                        ),
                                        child: Icon(
                                          Icons.cancel,
                                        ),
                                      ),
                                    ),
                                  ),
                                  verticalSpace(customHeight * 0.01),
                                  Container(
                                    height: customHeight * 0.3,
                                    child: Image.file(_displayImage!),
                                  ),
                                ],
                              ),
                        verticalSpace(customHeight * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (dropDownDepartment != null) {
                                if (_displayImage != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await MongoDb.insert({
                                    "name": nameController.text,
                                    "age": ageController.text,
                                    "phone": phoneController.text,
                                    "imageDp": base64Image,
                                    "department": dropDownDepartment,
                                  });
                                  setState(() {
                                    isLoading = false;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(successSnackBar);
                                    nameController.text = '';
                                    ageController.text = '';
                                    phoneController.text = '';
                                    _displayImage = null;
                                    dropDownDepartment = null;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(imageSnackBar);
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(deptSnackBar);
                              }
                            }
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
