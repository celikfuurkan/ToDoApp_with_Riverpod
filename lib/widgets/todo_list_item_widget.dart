
// ignore_for_file: must_be_immutable, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoriverpodapp/models/todo_model.dart';
import 'package:todoriverpodapp/providers/all_providers.dart';


class TodoListItemWidget extends ConsumerStatefulWidget{
  final TodoModel item;
  const TodoListItemWidget({ Key? key, required this.item }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState()=>_TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget>{
  late FocusNode _textFocusNode;
  late TextEditingController _TextController;

  bool _hasFocus=false;

  @override
  void initState() {
    
    super.initState();
    _textFocusNode = FocusScopeNode();
    _TextController = TextEditingController();

  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _TextController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context){
    return Focus(
      onFocusChange: (isFocused) {
        if(!isFocused){
          setState(() {
            _hasFocus=false;
          });

          ref.read(todoListProvider.notifier).edit(widget.item.id,  _TextController.text);
        }
      },
      child: ListTile(
        onTap: (){
          setState(() {
            _hasFocus=true;
          });
          _textFocusNode.requestFocus();
          _TextController.text = widget.item.description;
        },
        leading: Checkbox(
          value: widget.item.completed, 
          onChanged: (value){
          ref.read(todoListProvider.notifier).toggle(widget.item.id);
        },),title: _hasFocus ?  TextField(controller: _TextController, focusNode: _textFocusNode,) : Text(widget.item.description), //_hasFocus == true ise TextField() , _hasFocus == false ise Text(widget.item.description)
      ),
    );
  }
}
