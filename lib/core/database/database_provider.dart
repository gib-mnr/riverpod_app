
import 'package:riverpod_app/main.dart';

import 'database.dart';

// class DatabaseProvider {
//
//   final database = AppDb();
//
//   insertData() async {
//
//     await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
//       title: 'todo: finish drift setup',
//       content: 'We can now write queries and define our own tables.',
//     ));
//     List<TodoItem> allItems = await database.select(database.todoItems).get();
//
//     print('items in database: $allItems');
//   }
// }
