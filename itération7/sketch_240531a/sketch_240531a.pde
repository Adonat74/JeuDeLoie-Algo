int nbPlayers = 3;
int position[] = new int [nbPlayers];
int diceResult[] = new int [nbPlayers];
int rectLength = 12;
int[] gooseCells = {9, 18, 27, 36, 45, 54};
int playerTurn = 0;
int[] colors = new int [nbPlayers*3];
boolean isFixedCell = false;
int turn = 1;
int[] timeStuck = new int [nbPlayers];


int diceThrow (int playerNb) {
  

  int dice1 = (int)random(6)+1;
  int dice2 = (int)random(6)+1;

  if (turn == 1 && (dice1 == 3 || dice2 == 3) && (dice1 == 6 || dice2 == 6)) {
    position[playerNb] = 26;
    isFixedCell = true;
    return dice1+dice2;
  } else if (turn == 1 && (dice1 == 4 || dice2 == 4) && (dice1 == 5 || dice2 == 5)) {
    position[playerNb] = 53;
    isFixedCell = true;
    return dice1+dice2;
  } else if (turn == 1 && dice1+dice2 == 6) {
    position[playerNb] = 12;
    isFixedCell = true;
    return dice1+dice2;
  }
  isFixedCell = false;
  return dice1+dice2;
}



void play(int playerNb) {

  diceResult[playerNb] = diceThrow(playerNb);
  verifyGooseCells(playerNb);
  //verifyOtherPositions(playerNb);
  if (!isFixedCell) {
    position[playerNb] += diceResult[playerNb];
  }

  if (position[playerTurn] == 63) {
    noLoop();
    scoreFinalDisplay(playerTurn);
  } else if (position[playerNb] > 63) {
    position[playerTurn] = 63 - (position[playerTurn] - 63);
  }

  for (int i = 0; i < nbPlayers; i++) {
    scoreText(i);
    coloredRect(i);
  }
}

void draw() {
  
}



void keyPressed() {
  initBoardVisual();
  
  
  //delay(1000/nbPlayers);
  verifyOtherPositions(playerTurn);
  if (timeStuck[playerTurn] != 0) {
    playerTurn++;////////////////////////////////////////////////////////////////////////////////////////////////
  }
  play(playerTurn);
  playerTurn++;
  
  if (playerTurn == nbPlayers) {
    turn++;
    playerTurn = 0;
  }

}

void verifyGooseCells(int playerNb) {
  for (int i = 0; i < gooseCells.length; i++) {
    if (position[playerNb] == gooseCells[i]) {
      position[playerNb] += diceResult[playerNb];
    }
  }
}

void verifyOtherPositions(int playerNb) {
  if (position[playerNb] == 19) {
    coloredRect(playerNb);
    if(timeStuck[playerNb] <= 0){
      timeStuck[playerNb] = 2;
    }
    timeStuck[playerTurn]--;/////////////////////////////////////////////////////////////////////////////////////
    
    
  } else if (position[playerNb] == 42) {
    whiteRect(playerNb);
    position[playerNb] = 30;
    coloredRect(playerNb);
  } else if (position[playerNb] == 58) {
    whiteRect(playerNb);
    position[playerNb] = 0;
    coloredRect(playerNb);
  }
}


void scoreText(int playerNb) {
  fill(colors[playerNb*3], colors[playerNb*3+1], colors[playerNb*3+2]);
  textSize(20);
  text("position = " + position[playerNb], 50*(playerNb*3), 50);
  text("dice result = " + diceResult[playerNb], 50*(playerNb*3), 100);
}

void scoreFinalDisplay(int playerNb) {
  coloredRect(playerNb);
  fill(colors[playerNb*3], colors[playerNb*3+1], colors[playerNb*3+2]);
  text("position = " + position[playerNb], 50*(playerNb*3), 50);
  text("dice result = " + diceResult[playerNb], 50*(playerNb*3), 100);
}

void initBoardVisual() {
  background(75, 0, 145);
  for (int i = 0; i < 64; i++) {
    fill(230);
    rect(100+rectLength*i, 215, rectLength, 20);
  }
}

void colorInit() {
  for (int i = 0; i < colors.length; i++) {
    colors[i] = 100 + (int)random(155);
  }
}

void whiteRect(int playerNb) {
  fill(230);
  rect(100+rectLength*position[playerNb], 215, rectLength, 20);
}

void coloredRect(int playerNb) {
  fill(colors[playerNb*3], colors[playerNb*3+1], colors[playerNb*3+2]);
  rect(100+rectLength*position[playerNb], 215, rectLength, 20);
}

void setup() {
  colorInit();
  initBoardVisual();
  size(1000, 500);
}
