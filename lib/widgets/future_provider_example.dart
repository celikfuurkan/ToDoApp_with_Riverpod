
// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable, sort_child_properties_last

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoriverpodapp/models/cat_fact_model.dart';


final HttpClientProvider = Provider((ref) {
  return Dio(BaseOptions(baseUrl: 'https://catfact.ninja/' ));
});

final catsFactsProvider = FutureProvider<List<CatFactModel>>((ref) async{
  final _dio = ref.watch(HttpClientProvider);
  final _result = await _dio.get('facts');
  List<Map<String, dynamic>> _mapData = List.from(_result.data['data']) ;
  List<CatFactModel> _catFactList = _mapData.map((e) => CatFactModel.fromMap(e)).toList();
  return _catFactList;
});

class FutureProviderExample extends ConsumerWidget {
const FutureProviderExample({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    var _liste = ref.watch(catsFactsProvider);
    return Scaffold(
      body: SafeArea(
        child: _liste.when(data: (liste){
          return ListView.builder(itemCount: liste.length , itemBuilder: (context,index){
          return ListTile(
            title:  Text(liste[index].fact),
          );
      });
        }, 
          error: (error, stackTrace) {
            return Center(child:Text('Hata Çıktı ${error.toString()}') ,);
          },
           loading: ()=> const Center(child: CircularProgressIndicator(),)),
        ),
    );
  }
}