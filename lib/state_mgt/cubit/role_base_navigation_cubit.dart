import 'package:flutter_bloc/flutter_bloc.dart';

class RoleBaseNavigationCubit extends Cubit<String> {
  RoleBaseNavigationCubit() : super('');

  void setRole(String role) => emit(role);
}
