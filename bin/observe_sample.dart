import 'dart:mirrors';
import 'package:observe/observe.dart';

class App extends Object with ObservableMixin {
  @observable
  int counter = 0;
}

main() {
  var app = new App();
  
  app.changes
    .map((rec) => rec[0] as PropertyChangeRecord)
    .forEach((PropertyChangeRecord record) {
      var mirror = reflect(app);
      var fieldValue = mirror.getField(record.field).reflectee;
      print('Change to $fieldValue on ${record.field}');
    });
  
  app.counter++;
  Observable.dirtyCheck();
  
  app.counter++;
  app.counter++;
  
  Observable.dirtyCheck();
}