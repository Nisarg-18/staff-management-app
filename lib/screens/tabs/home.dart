import 'package:flutter/material.dart';
import 'package:staff_app/models/staffDetails.dart';
import 'package:staff_app/screens/personDetails.dart';
import 'package:staff_app/services/mongodb.dart';
import 'package:staff_app/services/commonFunctions.dart';
import 'package:staff_app/utils/customWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StaffDetails> details = [];
  bool isLoading = true;

  load() async {
    details = staffDetailsFromJson(await MongoDb.getData());
    if (details.isEmpty || details.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : details.isEmpty
              ? Center(
                  child: Text(
                    'No Data Available',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      verticalSpace(customHeight * 0.02),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: details.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PersonDetailsScreen(
                                        onePerson: details[index]);
                                  }));
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 15,
                                ),
                                leading: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: imageFromBase64String(
                                      details[index].imageDp),
                                ),
                                title: Text(
                                  details[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
    );
  }
}
