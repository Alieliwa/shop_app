import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/modules/login/login.dart';
import 'package:medica_zone/shared/components/components.dart';
import 'package:medica_zone/shared/network/local/cache_helper.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

void printFullText(String  text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>  print(match.group(0)));
}

String token = '';

void SignOut(context){
   CacheHelper.removeData(key: 'token').then((value) {
                     if(value)
                       navigateAndFinish(context, Login());
                   });
}
