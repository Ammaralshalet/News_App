import 'package:flutter/material.dart';

@immutable
sealed class ManagerState {}

final class ManagerInitial extends ManagerState {}

class NavigateToLogIn extends ManagerState {}

class NavigateToOffline extends ManagerState {}

class NavigateToHomePage extends ManagerState {}
