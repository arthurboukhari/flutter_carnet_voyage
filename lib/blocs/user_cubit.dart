import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/user_repository.dart';

class UserCubit extends Cubit<bool> {
  UserRepository userRepository;
  UserCubit(this.userRepository) : super(false);

  Future<void> init() async {
    try {
      emit(await userRepository.init());
    } catch (e) {
      emit(false);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await userRepository.login(email, password);
      emit(true);
    } catch (e) {
      emit(false);
    }
  }

  Future<void> signup(String email, String password, String username) async{
    try {
      await userRepository.signup(email, password, username);
      emit(true);
    } catch (e){
      emit(false);
    }
  }

  Future<void> logout() async {
    try {
      await userRepository.logout();
      emit(false);
    } catch (e) {}
  }
}
