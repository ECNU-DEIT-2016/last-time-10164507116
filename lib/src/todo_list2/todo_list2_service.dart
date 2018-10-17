import 'dart:async';

import 'package:angular/core.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class TodoList2Service {
  List<String> mockTodoList2 = <String>[];

  Future<List<String>> getTodoList2() async => mockTodoList2;
}
