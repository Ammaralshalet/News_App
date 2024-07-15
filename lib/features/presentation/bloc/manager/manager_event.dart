import 'package:flutter/material.dart';

@immutable
sealed class ManagerEvent {}

class HeLoggedIn extends ManagerEvent {}

class HeFailedToLoggedIn extends ManagerEvent {}

class RestoreToLogIn extends ManagerEvent {}

class CheckAuthorized extends ManagerEvent {}

class LogOut extends ManagerEvent {}

class ExcuteLastRequest extends ManagerEvent {}
