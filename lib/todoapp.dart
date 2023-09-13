
// ignore_for_file: must_be_immutable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:todoriverpodapp/widgets/future_provider_example.dart';
import 'package:todoriverpodapp/widgets/title_widget.dart';
import 'package:todoriverpodapp/widgets/todo_list_item_widget.dart';
import 'package:todoriverpodapp/widgets/toolbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoriverpodapp/providers/all_providers.dart';

class TodoApp extends ConsumerWidget {
 TodoApp({ Key? key }) : super(key: key);

  final newTodoController = TextEditingController();
  

  @override
  Widget build(BuildContext context, WidgetRef ref){
    var allTodos = ref.watch(filteredTodoList);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children:  [
        const TitleWidget(),
        TextField(
          controller: newTodoController,
          decoration: const InputDecoration(labelText: 'Neler yapacaksın bu gün?'),
          onSubmitted: (value) {
            ref.read(todoListProvider.notifier).addTodo(value.toString());
          },
        ),
        const SizedBox(height: 20),
         ToolbarWidget(),

        allTodos.length == 0 ? const Center(child: Text('Bu koşullarda Herhangi Bir Görev Yok')): const SizedBox(),
      
        for(var i=0; i<allTodos.length; i++ )
           Dismissible(key:ValueKey(allTodos[i].id), onDismissed:(_){
              ref.read(todoListProvider.notifier).remove(allTodos[i]);
           } ,child: TodoListItemWidget(item:allTodos[i])),

        ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const FutureProviderExample(),));
        }, child: const Text('Future Provider Example')),
        
      ]),
    );
  }
}