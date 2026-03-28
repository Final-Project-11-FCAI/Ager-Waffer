import 'package:ager_waffer/Features/Authentication/login/data/models/login_model.dart';
import 'package:equatable/equatable.dart';
enum loginStatus{initial,loading,success,failure}
class LoginState extends Equatable{
  Data user;
  loginStatus status;
  String failureMessage ;
  LoginState({required this.user,required this.status, this.failureMessage = ''});

  @override
  List<Object?> get props => [user,status,failureMessage];

  LoginState copyWith({Data? user,loginStatus? status, String? failureMessage}){
    return LoginState(
        user: user ?? this.user,
        status: status ?? this.status,
        failureMessage: failureMessage ?? this.failureMessage);
  }
}