import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medica_zone/models/SearchModel/search_model.dart';
import 'package:medica_zone/modules/search_Screen/cubit/search_states.dart';
import 'package:medica_zone/shared/components/constants.dart';
import 'package:medica_zone/shared/network/end_points.dart';
import 'package:medica_zone/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchStates());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Search(String? text)
  {
    emit(SearchLoadingStates());
    DioHelper.postData(
        url: SEARCH,
        authToken: token,
        data: {
          'text':text
        },
    ).then((value){

      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSeccuessStates());


    }).catchError((Error){
      print('Search Error $Error');
      emit(SearchErrorStates());
    });

}


}