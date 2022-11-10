import 'package:realm/realm.dart';

import 'models/expense.dart';
import 'models/category.dart';

var _config = Configuration.local([Expense.schema, Category.schema]);
var realm = Realm(_config);
