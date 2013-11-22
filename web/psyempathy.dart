import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

ButtonElement okButton;
DivElement questBlock;

List<int> answerList;
int curAnswerNumber;

void main() {
  okButton = querySelector('#ok-button');
  questBlock = querySelector('#quest-text');
  
  okButton.onClick.listen(okButton_Click);
  
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
    answerList = [];
    curAnswerNumber = 0;
  }
}

void okButton_Click(MouseEvent event) {
  InputElement radio = querySelector("input[type='radio']:checked");
  if (radio == null) {
    window.alert("Не выбран вариант ответа");
    return;
  }
  answerList.add(int.parse(radio.value));
  curAnswerNumber++;
  if (curAnswerNumber == Quests.texts.length) {
    window.alert(answerList.toString());
    okButton.disabled = true;
    return;
  }
  questBlock.text = Quests.texts[curAnswerNumber];
  radio.checked = false;
}
