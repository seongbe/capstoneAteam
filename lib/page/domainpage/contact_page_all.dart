import 'package:capstone/component/contact_container_blue.dart';
import 'package:flutter/material.dart';
import 'package:capstone/page/domainpage/contact_detail_end.dart';
import 'package:capstone/page/domainpage/contact_detail_wait.dart';
import 'package:get/get.dart';
import '../../component/contact_container_red.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPageAll extends StatefulWidget {
  const ContactPageAll({Key? key}) : super(key: key);

  @override
  _ContactPageAllState createState() => _ContactPageAllState();
}

class _ContactPageAllState extends State<ContactPageAll> {
  late Stream<QuerySnapshot> _contactStream;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contactStream = FirebaseFirestore.instance.collection('ContactTest').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: Center(
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      // Trigger a rebuild when the search text changes
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '사용자 ID, 문의명, 문의 종류를 검색하세요.',
                    hintStyle: TextStyle(
                      color: Color(0xffC0C0C0),
                      fontFamily: 'mitmi',
                    ),
                    filled: true,
                    fillColor: Color(0xffF8FFF2),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    prefixIcon: Icon(Icons.search),
                    prefixIconConstraints: BoxConstraints(minWidth: 48),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _contactStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                String searchText = _searchController.text.toLowerCase();
                var filteredDocs = snapshot.data!.docs.where((doc) {
                  String inquiryName = doc['inquiry_name'].toLowerCase();
                  String inquiryType = doc['inquiry_type'].toLowerCase();
                  String userId = doc['user_id'].toLowerCase();
                  return inquiryName.contains(searchText) ||
                      inquiryType.contains(searchText) ||
                      userId.contains(searchText);
                }).toList();

                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    var data = filteredDocs[index].data() as Map<String, dynamic>;
                    bool state = data['state'];
                    String inquiryName = data['inquiry_name'];
                    String inquiryType = data['inquiry_type'];
                    String id = data['user_id'];
                    String date = data['date'];
                    String contactId = data['contact_id'];

                    return GestureDetector(
                      onTap: () {
                        if (state) {
                          Get.to(ContactDetailEnd(contactId: contactId));
                        } else {
                          Get.to(ContactDetailWait(contactId: contactId));
                        }
                      },
                      child: state
                          ? ContactContainer_BLUE(
                        inquiryName: inquiryName,
                        inquiryType: inquiryType,
                        id: id,
                        date: date,
                        contactId: contactId,
                      )
                          : ContactContainer_RED(
                        inquiryName: inquiryName,
                        inquiryType: inquiryType,
                        id: id,
                        date: date,
                        contactId: contactId,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
