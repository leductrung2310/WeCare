import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/statistic_data/bmi_ratio_data.dart';
import 'package:wecare_flutter/view_model/home_vm/bmi_view_model.dart';

import '../../../../constants/firestore_constants.dart';

class BMIHistorySection extends StatelessWidget {
  const BMIHistorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    Column bmiItem(BMIRatio bmiRatio, Color color) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: sizeH * 16,
                child: Text(
                  bmiRatio.ratio.toString(),
                  style: TextStyle(
                    color: bmiColor,
                    fontSize: sizeV * 3,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Container(
                height: sizeH * 3,
                width: sizeH * 3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              SizedBox(
                width: sizeH * 25,
                child: Text(
                  DateFormat('dd-MM-yyyy')
                      .format(bmiRatio.updatedDate ?? DateTime.now()),
                  style: TextStyle(
                    color: metalGreyColor,
                    fontSize: sizeV * 2.2,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          Divider(
            indent: sizeH * 4,
            endIndent: sizeH * 4,
            thickness: 1,
            color: metalGreyColor,
            height: sizeV * 1.5,
          ),
        ],
      );
    }

    Color calculateStatus(BMIRatio bmiRatio) {
      double ratio = bmiRatio.ratio ?? 0;
      if (ratio >= 16 && ratio <= 18.5) {
        return const Color(0xFF82B6E7);
      }
      if (ratio >= 18.6 && ratio <= 25) {
        return primaryColor;
      }
      if (ratio >= 25.1 && ratio <= 40) {
        return const Color(0xFFE06D53);
      }
      return metalGreyColor;
    }

    return Column(
      children: [
        Divider(
          height: 2,
          thickness: 1.5,
          indent: sizeH * 10,
          endIndent: sizeH * 10,
          color: metalGreyColor,
        ),
        Text(
          'History',
          style: TextStyle(
            color: lightBlack,
            fontSize: sizeV * 4,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(sizeH * 8, sizeV, sizeH * 8, sizeV * 2),
          padding: EdgeInsets.all(sizeV),
          height: 250,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FireStoreConstants.pathBMICollection)
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection(FireStoreConstants.bmiHistory)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text("There's nothing here");
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  BMIRatio bmiRatio = BMIRatio.fromDocument(documentSnapshot);
                  return bmiItem(bmiRatio, calculateStatus(bmiRatio));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
