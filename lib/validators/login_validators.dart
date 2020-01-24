import 'dart:async';

class LoginValidators {
  final emailValidator = StreamTransformer<String,String>.fromHandlers(
    handleData: (event,sink) {
      if(event.isEmpty) {
         sink.addError("Digite o seu usuario");
      } else {
        sink.add(event);
      }
    }
  );

  final passowrdValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (event,sink) {
        if(event.isEmpty) {
          sink.addError("Digite a sua senha");
        } else {
          sink.add(event);
        }
      }
  );
}