import 'package:capstone/component/contact_container_blue.dart';
import 'package:flutter/material.dart';
import "package:capstone/page/domainpage/contact_detail_end.dart";
import "package:capstone/page/domainpage/contact_detail_wait.dart";
import 'package:get/get.dart';
import '../../component/contact_container_red.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPageAll extends StatelessWidget {
  const ContactPageAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ContactTest').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
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
                    ?ContactContainer_BLUE(
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
    );
  }
}
