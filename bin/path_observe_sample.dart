import 'dart:async';
import 'package:observe/observe.dart';

class App extends Object with ObservableMixin {
  @observable
  int counter = 0;
}

main() {
  var app = new App();
  
  new PathObserver(app, 'counter')
    .bindSync((newValue) => print('counter changed to $newValue'));
  
  new Timer.periodic(const Duration(seconds: 1), (t) {
    app.counter++;
    // Required.
    Observable.dirtyCheck();
  });
}