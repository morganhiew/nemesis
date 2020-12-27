import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:nemesis/authentication/models/email.dart';
import 'package:nemesis/authentication/models/password.dart';
import 'package:nemesis/login/cubit/login_cubit.dart';

class MyInfoState extends Equatable {
  const MyInfoState({
    this.nickname = '名称',
    this.phone = '電話',
    this.address = '住所',
    this.status = FormzStatus.pure,
  });

  final String nickname;
  final String phone;
  final String address;
  final FormzStatus status;

  @override
  List<Object> get props => [nickname, phone, address, status];

  MyInfoState copyWith({
    String nickname,
    String phone,
    String address,
    FormzStatus status,
  }) {
    return MyInfoState(
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      status: status ?? this.status,
    );
  }
}

