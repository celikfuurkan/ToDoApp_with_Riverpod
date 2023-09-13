// ignore_for_file: unused_local_variable, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_final_fields, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoriverpodapp/providers/all_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({ Key? key }) : super(key: key);
  var currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt){
    return currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref){
    
    final onComplotedTodoCount = ref.watch(unCompletedTodoCount);
    final currentFilter = ref.watch(todoListFilter);

    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [ Expanded(child: Text(onComplotedTodoCount==0?'Tüm görevler okey': onComplotedTodoCount.toString()+" Görev tamamlanmadı", overflow: TextOverflow.ellipsis,)),
      Tooltip(
        message: 'All Todos',
        child: TextButton(
          style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)) ,
          onPressed:(){
          ref.read(todoListFilter.notifier).state = TodoListFilter.all;
        },
        child: const Text('All') ,),
      ),
      Tooltip(
        message: 'Only Uncompleted Todos',
        child: TextButton(
          style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.active)) ,
          onPressed:(){
          ref.read(todoListFilter.notifier).state = TodoListFilter.active;
        },
        child: const Text('Active') ,),
      ),
      Tooltip(
        message: 'Only Completed Todos',
        child: TextButton(
          style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.completed)) ,
          onPressed:(){
          ref.read(todoListFilter.notifier).state = TodoListFilter.completed;
        },
        child: const Text('Completed') ,),
      )
      
      ],
    );
  }
}