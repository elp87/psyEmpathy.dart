library psyempathy.Quests;

import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

class Quests {
  static List<String> texts = [];
  
  static Future readyQuests() {
    var path = 'json/questions.json';
    HttpRequest.getString(path).then(_parseQuestFromJSON).then(_prepareControls);    
  }
  
  static _parseQuestFromJSON(String jsonString) {
    Map quests = JSON.decode(jsonString);
    texts = quests['quests'];    
  }
  
  static _prepareControls(dynamic value) {
    querySelector('#quest-text').text = texts[0];
    ButtonElement okButton = querySelector('#ok-button');
    okButton.disabled = false;
  }
  
}