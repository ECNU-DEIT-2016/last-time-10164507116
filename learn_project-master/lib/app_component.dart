import 'package:angular/angular.dart';

import 'src/todo_list/todo_list_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  template: '''
  <h1>My First AngularDart App in inline temlate</h1>

<todo-list></todo-list>

  ''',
  directives: [TodoListComponent],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
