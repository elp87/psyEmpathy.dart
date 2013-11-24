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
    showResult();
    window.alert("Ваша достоверность - ${curTest.honesty}");
    okButton.disabled = true;
    return;
  }
  questBlock.text = Quests.texts[curAnswerNumber];
  radio.checked = false;
}

void showResult() {
  if (curTest.testValue >= 82) { window.alert(curTest.descriptionsList[0].longDesc); }
  if (curTest.testValue >= 63 && curTest.testValue <= 81) { window.alert(curTest.descriptionsList[1].longDesc); }
  if (curTest.testValue >= 37 && curTest.testValue <= 62) { window.alert(curTest.descriptionsList[2].longDesc); }
  if (curTest.testValue >= 12 && curTest.testValue <= 36) { window.alert(curTest.descriptionsList[3].longDesc); }
  if (curTest.testValue <= 11) { window.alert(curTest.descriptionsList[4].longDesc); }
}

prepareTest() {
  curAnswerNumber = 0;
}
