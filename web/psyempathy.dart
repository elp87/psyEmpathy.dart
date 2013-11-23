import 'dart:html';
import 'dart:async' show Future;
import 'lib/Quests.dart';
import 'lib/Testing.dart'; 

ButtonElement okButton;
DivElement questBlock;
int curAnswerNumber;
Testing curTest;

void main() {
  okButton = querySelector('#ok-button');
  questBlock = querySelector('#quest-text');
  curTest = new Testing();
  
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
  curTest.answers.add(int.parse(radio.value));
  curAnswerNumber++;
  if (curAnswerNumber == Quests.texts.length) {
    curTest.calcResults();
    window.alert("Ваша достоверность - ${curTest.honesty}");
    okButton.disabled = true;
    return;
  }
  questBlock.text = Quests.texts[curAnswerNumber];
  radio.checked = false;
}

prepareTest() {
  curAnswerNumber = 0;
}
