import 'package:flutter/material.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class SuccessToLogIn extends AuthState {}

class FailedToLogIn extends AuthState {}
