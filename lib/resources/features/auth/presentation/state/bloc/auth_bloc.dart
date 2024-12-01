import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/https_consumer.dart';
import '../../../../../core/cache/database_helper.dart';
import '../../../../../core/utils/result.dart';
import '../../../../../../main.dart';
import '../../../data/datasources/auth_datasource.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/use_cases/governorates_use_case.dart';
import '../../../domain/use_cases/login_usecase.dart';
import '../../../domain/use_cases/register_usecase.dart';
import '../../../domain/use_cases/send_otp_usecase.dart';

part 'auth_events.dart';

part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SendOTPRequest>(_sendOTP);
    on<LoginRequest>(_login);
    on<LogoutRequest>(_logout);
    on<RegisterRequest>(_register);
    on<FetchGovernorates>(_fetchGovernorates);
  }

  Future<void> _fetchGovernorates(
    FetchGovernorates event,
    Emitter<AuthState> emit,
  ) async {
    emit(FetchGovernoratesLoading(isLogin: event.isLogin));
    final Result result = await FetchGovernoratesUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call();
    if (result.isSuccess) {
      return emit(FetchGovernoratesSuccess(isLogin: event.isLogin));
    } else {
      return emit(FetchGovernoratesFailure(failure: result.error));
    }
  }

  Future<void> _sendOTP(SendOTPRequest event, Emitter<AuthState> emit) async {
    emit(SendOTPLoading());
    final Result result = await SendOTPUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(event.phoneNumber);
    if (result.isSuccess) {
      return emit(SendOTPSuccess());
    } else {
      return emit(SendOTPFailure(failure: result.error));
    }
  }

  Future<void> _login(LoginRequest event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    final Result result = await LoginUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(event.phoneNumber, event.otp);
    if (result.isSuccess) {
      preferences!.setBool('loggedIn', true);
      return emit(LoginSuccess());
    } else {
      return emit(LoginFailure(failure: result.error));
    }
  }

  Future<void> _logout(LogoutRequest event, Emitter<AuthState> emit) async {
    emit(LogoutLoading());
    await preferences!.clear();
    await DatabaseHelper().deleteAllTasks();
    await DatabaseHelper().deleteAllWaitingTasks();
    await DatabaseHelper().deleteAllDeletedTasks();
    emit(LogoutSuccess());
  }

  Future<void> _register(
    RegisterRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterLoading());
    final Result result = await RegisterUseCase(
      authRepositoryImpl: AuthRepositoryImpl(
        authDatasourece: AuthDatasource(
          httpsConsumer: HttpsConsumer(),
        ),
      ),
    ).call(
      event.fullName,
      event.phoneNumber,
      event.governorate,
      event.avatar,
    );
    if (result.isSuccess) {
      return emit(RegisterSuccess());
    } else {
      return emit(RegisterFailure(failure: result.error));
    }
  }
}
