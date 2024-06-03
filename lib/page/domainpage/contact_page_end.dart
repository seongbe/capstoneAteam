import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/page/domainpage/contact_detail_end.dart';

import '../../component/contact_container_blue.dart';

class ContactPageEnd extends StatelessWidget {
  const ContactPageEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ContactTest').where('state', isEqualTo: true).snapshots(),
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
              String inquiryName = data['inquiry_name'];
              String inquiryType = data['inquiry_type'];
              String id = data['user_id'];
              String date = data['date'];
              String contactId = data['contact_id'];

              return GestureDetector(
                onTap: () {
                  Get.to(ContactDetailEnd(contactId: contactId,));
                },
                child: ContactContainer_BLUE(
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
