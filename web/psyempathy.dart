import 'dart:html';
import 'dart:async' show Future;
import 'lib/Quests.dart';

ButtonElement okButton;
DivElement questBlock;

List<int> answerList;
int curAnswerNumber;

void main() {
  okButton = querySelector('#ok-button');
  questBlock = querySelector('#quest-text');
  
  okButton.onClick.listen(okButton_Click);
  
  Quests.readyQuests();
  prepareTest();
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

prepareTest() {
  answerList = [];
  curAnswerNumber = 0;
}
