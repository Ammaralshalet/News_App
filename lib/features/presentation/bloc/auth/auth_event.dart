import 'package:flutnews/model/user/user_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent {}

class LogIn extends AuthEvent {
  final UserModel user;

  LogIn({required this.user});
}
