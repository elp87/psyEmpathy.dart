library psyempathy.Testing;

import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

class Testing {
  static final List<int> significantQuests = [2, 5, 8, 9, 10, 12, 13, 15, 16, 19, 21, 22, 24, 25, 26, 27, 29, 32];
  static final List<int> dontKnowHonesty = [3, 9, 11, 13, 28, 36];
  static final List<int> yesHonesty = [11, 13, 15, 27]; 
  
  List<int> answers;
  List<resultDescription> descriptionsList;
  int _testValue, _honesty;
  
  Testing() {
    answers = [];
    this._prepareJSON();
  }
  
  void calcResults() {
    if (answers.length != 36) {
      int l = answers.length;
      throw new IncompleteTestError("Test is incomplete. It is $l answers");
    }
    
    _honesty = _calcHonesty();
    _testValue = _calcTestValue();
  }
  
  void _prepareJSON() {
    String path = 'json/resultDescriptions.json';
    HttpRequest.getString(path).then(_parseDescriptionsFromJSON);
  }
  
  void _parseDescriptionsFromJSON(String jsonString) {
    descriptionsList = [];
    Map jsonMap = JSON.decode(jsonString);
    List descs = jsonMap['descriptions'];
    for (var element in descs) {
      String s = element['short'];
      String l = element['long'];
      resultDescription newDesc = new resultDescription(s, l);
      descriptionsList.add(newDesc);
    }
  }
  
  int _calcHonesty() {
    int result = 0;
    for (int index in dontKnowHonesty) {
      if (answers[index - 1] == 0) { result++; }
    }
    for (int index in yesHonesty) { 
      if (answers[index - 1] == 5) { result++; }
    }
    return result;
  }
  
  int _calcTestValue() {
    int result = 0;
    for (int index in significantQuests) {
      result += answers[index - 1];
    }
    return result;
  }
  
  int get testValue => _testValue;
  int get honesty => _honesty;
}

class IncompleteTestError extends Error {
  String message;
  
  IncompleteTestError(String message) {
    this.message = message;
  }
}

class resultDescription {
  String shortDesc;
  String longDesc;
    
  resultDescription(String short, String long){
    this.longDesc = long;
    this.shortDesc = short;
  }
  
}