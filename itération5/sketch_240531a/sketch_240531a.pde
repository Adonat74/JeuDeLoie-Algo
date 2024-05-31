int board[] = new int[64];
int position = 0;
int diceResult = 0;
int rectLength = 12;
int throwCount = 0;
int[] gooseCells = {9, 18, 27, 36, 45, 54};


int diceThrow () {
  int dice1 = (int)random(6)+1;
  int dice2 = (int)random(6)+1;
  if(throwCount == 0 && (dice1 == 3 || dice2 == 3 && dice1 == 6 || dice2 == 6)) {
    position = 26;
    throwCount++;
    return 0;
  } else if (throwCount == 0 && (dice1 == 4 || dice2 == 4 && dice1 == 5 || dice2 == 5)) {
    position = 53;
    throwCount++;
    return 0; 
  } else if (throwCount == 0 && dice1+dice2 == 6) {
    position = 12;
    throwCount++;
    return 0; 
  }
  throwCount++;
  return dice1+dice2;
}



void play() {
  delay(1000);
  fill(255, 0, 0);
  rect(100+rectLength*position, 215, rectLength, 20);
  scoreText();
  diceResult = diceThrow();
  verifyGooseCells();
  verifyOtherPositions();
  position += diceResult;
}

void draw() {
  initBoardVisual();
  if (position == 63) {
    noLoop();
    scoreFinalDisplay();
  } else if (position > 63) {
    position = 63 - (position - 63);
    play();
  } else {
    play();  
  }
}

void verifyGooseCells() {
  for (int i = 0; i < gooseCells.length; i++) {
    if (position == gooseCells[i]) {
      position += diceResult; 
    }
  }
}

void verifyOtherPositions() {
  if (position == 19) {
    fill(255, 0, 0);
    rect(100+rectLength*position, 215, rectLength, 20);
    delay(2000);
  } else if (position == 42) {
    fill(255);
    rect(100+rectLength*position, 215, rectLength, 20);
    position = 30;
    fill(255, 0, 0);
    rect(100+rectLength*position, 215, rectLength, 20);
  } else if (position == 58) {
    fill(255);
    rect(100+rectLength*position, 215, rectLength, 20);
    position = 0;
    fill(255, 0, 0);
    rect(100+rectLength*position, 215, rectLength, 20);
  }
}


void initBoardVisual() {
  background(103, 0, 216);
  for (int i = 0; i < board.length; i++) {
    fill(255);
    rect(100+rectLength*i, 215, rectLength, 20); 
  }
}

void scoreText() {
  fill(255);
  textSize(20);
  text("position = " + position, 50, 50);
  text("dice result = " + diceResult, 50, 100);
}

void scoreFinalDisplay() {
  fill(255, 0, 0);
  rect(100+rectLength*position, 215, rectLength, 20);
  fill(255);
  text("position = " + position, 50, 50);
  text("dice result = " + diceResult, 50, 100);
}


void setup() {
  background(103, 0, 216);
  size(1000, 500);
}
