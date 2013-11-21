import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

ButtonElement okButton;
DivElement questBlock;

void main() {
  okButton = querySelector('#ok-button');
  questBlock = querySelector('#quest-text');
  
  Quests.readyQuests();  
}

class Quests {
  static List<String> texts = [];
  
  static Future readyQuests() {
    var path = 'questions.json';
    return HttpRequest.getString(path).then(_parseQuestFromJSON).then(_prepareControls);
  }
  
  static _parseQuestFromJSON(String jsonString) {
    Map quests = JSON.decode(jsonString);
    texts = quests['quests'];
  }
  
  static _prepareControls(dynamic value) {
    questBlock.text = texts[0];
    okButton.disabled = false;
  }
}


