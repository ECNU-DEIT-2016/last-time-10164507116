
import 'dart:async';            
import 'package:angular/angular.dart';            
import 'package:angular_components/angular_components.dart';            
import 'package:intl/intl.dart';       
import 'todo_list2_service.dart';                
@Component(
selector: 'todo-list2',
styleUrls: ['todo_list2_component.css'],
templateUrl: 'todo_list2_component.html',           
directives: [                       
MaterialIconComponent,            
MaterialProgressComponent,   
ScorecardComponent,                        
],            
       
 providers: [materialProviders,const ClassProvider(TodoList2Service)],
 
//component !important !import

)
class TodoList2Component implements OnInit {
  

  
  int altCash=100;

 
  int cash=200;

  String get outcomeDescription {
    if (cash == altCash) return "no difference";
    double multiple = cash / altCash;
    if (cash > altCash) {
      int percentage = ((multiple - 1) * 100).round();
      return "$percentage% better";
    }
    int percentage = ((1 - multiple) * 100).round();
    return "$percentage% worse";
  }


  final TodoList2Service todoList2Service;

   List<String> items = [];
  String newTodo2 = '';

  TodoList2Component(this.todoList2Service);

  @override
  Future<Null> ngOnInit() async {
    items = await todoList2Service.getTodoList2();
  }
  void add() {
    items.add(newTodo2);
    newTodo2 = '';
  }

  String remove(int index) => items.removeAt(index);

}
