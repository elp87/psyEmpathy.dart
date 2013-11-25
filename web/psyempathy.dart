import 'dart:html';
import 'dart:async' show Future;
import 'lib/Quests.dart';
import 'lib/Testing.dart'; 

ButtonElement okButton;
DivElement questBlock;
DivElement testBlock;
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
    prepareWindowForResult();
    showResult();
    return;
  }
  questBlock.text = Quests.texts[curAnswerNumber];
  radio.checked = false;
}

void prepareWindowForResult() {
  okButton = null;
  questBlock = null;
  testBlock = querySelector('#test-block');
  testBlock.innerHtml = '<div id="honesty-block"> Искренность ответов </div> <div id="testResult-short"> Коротко </div> <div id="testResult-long"> Развернуто </div>';
}

void showResult() {
  String shortResult, longResult;
  DivElement honestyDiv = querySelector('#honesty-block');
  honestyDiv..innerHtml = getHonestyDescription()
            ..style.background = getHonestyBlockColor();
            
  DivElement shortDiv = querySelector('#testResult-short');
  DivElement longDiv = querySelector('#testResult-long');
    
  if (curTest.testValue >= 82) { 
    longResult = curTest.descriptionsList[0].longDesc;
    shortResult = curTest.descriptionsList[0].shortDesc;
    shortDiv.style.background = "red";
  }
  if (curTest.testValue >= 63 && curTest.testValue <= 81) { 
    longResult = curTest.descriptionsList[1].longDesc;
    shortResult = curTest.descriptionsList[1].shortDesc;
    shortDiv.style.background = "yellow";
  }
  if (curTest.testValue >= 37 && curTest.testValue <= 62) { 
    longResult = curTest.descriptionsList[2].longDesc;
    shortResult = curTest.descriptionsList[2].shortDesc;
    shortDiv.style.background = "green";
  }
  if (curTest.testValue >= 12 && curTest.testValue <= 36) { 
    longResult = curTest.descriptionsList[3].longDesc;
    shortResult = curTest.descriptionsList[3].shortDesc;
    shortDiv.style.background = "yellow";
  }
  if (curTest.testValue <= 11) { 
    longResult = curTest.descriptionsList[4].longDesc;
    shortResult = curTest.descriptionsList[4].shortDesc;
    shortDiv.style.background = "red";
  }
  
  shortDiv.innerHtml = shortResult;
  longDiv.innerHtml = longResult;
}

String getHonestyDescription() {
  String honestyDescription = "";
  if (curTest.honesty == 4) { honestyDescription = "Клиент был не до конца честен. В результатах теста следует сомневаться"; }
  if (curTest.honesty >= 5) { honestyDescription = "Клиент был не честен. Результатам теста верить нельзя";  }
  return honestyDescription;  
}

getHonestyBlockColor() {
  String backgroundColor = "";
  if (curTest.honesty == 4) { backgroundColor = "yellow"; }
  if (curTest.honesty >= 5) { backgroundColor = "red";  }
  return backgroundColor;
}

prepareTest() {
  curAnswerNumber = 0;
}
