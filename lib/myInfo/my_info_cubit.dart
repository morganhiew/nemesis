import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formz/formz.dart';
import 'package:nemesis/teacherList/teacherClass.dart';

import 'my_info_state.dart';

class MyInfoCubit extends Cubit<MyInfoState> {
  MyInfoCubit() : super(const MyInfoState());

  CollectionReference users = FirebaseFirestore.instance
      .collection('users');

  void refresh() {
    emit(state.copyWith(status: FormzStatus.pure));
  }

  Future<void> getInfo({uid}) async {
    print('get info');
    users
        .where("uid", isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.length > 0) {
            QueryDocumentSnapshot result = querySnapshot.docs[0];
            emit(state.copyWith(nickname: result.get('nickname'), phone: result.get('phone'), address: result.get('address'), status: FormzStatus.valid));
          }
        });
  }

  Future<void> updateInfo({uid, nickname, phone, address}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      users
          .where("uid", isEqualTo: uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.length > 0) {
              querySnapshot.docs[0].reference.update({"nickname":nickname, "phone":phone, "address":address});
            } else{
              users.add({"uid": uid, "nickname":nickname, "phone":phone, "address":address})
                  .then((value) => print("User Added"))
                  .catchError((error) => print("Failed to add user: $error"));
            }
          });
      emit(state.copyWith(nickname: nickname, phone: phone, address: address, status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }


}
