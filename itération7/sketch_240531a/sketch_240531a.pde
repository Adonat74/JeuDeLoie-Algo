int nbPlayers = 6;
int position[] = new int [nbPlayers];
int diceResult[] = new int [nbPlayers];
int rectLength = 20;
int[] gooseCells = {9, 18, 27, 36, 45, 54};
int playerTurn = 0;
int[] colors = new int [nbPlayers*3];
boolean isFixedCell = false;
int turn = 1;
int[] timeStuck = new int [nbPlayers];
int whichPlayerInHole = 100;
int whichPlayerInPrison = 100;
boolean isPrisonOccupied = false;

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
  if (!isFixedCell) {
    position[playerNb] += diceResult[playerNb];
  }
  verifyGooseCells(playerNb);
  if (position[playerTurn] == 63) {
    noLoop();
    scoreFinalDisplay(playerTurn);
  } else if (position[playerNb] > 63) {
    position[playerTurn] = 63 - (position[playerTurn] - 63);
  }
  verifyOtherPositions(playerTurn);
  refreshRect();
}

void draw() {
}
void keyPressed() {
  initBoardVisual();
  verifyIsLastPlayer();
  timeStuck[playerTurn]--;
  
  verifyIsLastPlayer();
  
  if (timeStuck[playerTurn] <= 0 && whichPlayerInHole != playerTurn && whichPlayerInPrison != playerTurn) {
    play(playerTurn);
  } else {
    refreshRect(); 
  }
  playerTurn++;
  
}

void refreshRect() {
  for (int i = 0; i < nbPlayers; i++) {
    scoreText(i);
    coloredRect(i);
  }
}

void verifyIsLastPlayer() {
  if (playerTurn >= nbPlayers) {
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
  println(position[playerNb]);
  if(position[playerNb] == 3){
    whichPlayerInHole = playerNb;
  } else if (position[playerNb] == 19) {
    
    coloredRect(playerNb);
    whiteRect(playerNb);
    if (timeStuck[playerNb] < 0) {
      timeStuck[playerNb] = 2;
    }   
    
  } else if (position[playerNb] == 42) {
    position[playerNb] = 30;
  } else if (position[playerNb] == 52) {
    
    if (!isPrisonOccupied) {
      whichPlayerInPrison = playerNb;
      isPrisonOccupied = !isPrisonOccupied;
    } else {
      whichPlayerInPrison = 100;
    }
    
  } else if (position[playerNb] == 58) {
    position[playerNb] = 0;
  }
  println(position[playerNb]);
}


void scoreText(int playerNb) {
  fill(colors[playerNb*3], colors[playerNb*3+1], colors[playerNb*3+2]);
  textSize(20);
  text("position = " + position[playerNb], 100+(50*(playerNb*3)), 50);
  text("dice result = " + diceResult[playerNb], 100+(50*(playerNb*3)), 100);
}

void scoreFinalDisplay(int playerNb) {
  coloredRect(playerNb);
  fill(colors[playerNb*3], colors[playerNb*3+1], colors[playerNb*3+2]);
  textSize(20);
  text("position = " + position[playerNb], 100+(50*(playerNb*3)), 50);
  text("dice result = " + diceResult[playerNb], 100+(50*(playerNb*3)), 100);
}

void initBoardVisual() {
  background(136, 0, 170);
  for (int i = 0; i < 64; i++) {
    fill(255);
    rect(100+rectLength*i, 215, rectLength, nbPlayers*20);
    textSize(16);
    text(i, 102+rectLength*i, 210);
  }
  for (int i = 0; i < gooseCells.length; i++) {
    fill(0, 135, 136);
    textSize(30);
    text("Oies ", 100, 400);
    rect(100+rectLength*gooseCells[i], 215, rectLength, nbPlayers*20);
  }
  fill(132, 254, 2);
  text("Puits ", 300, 400);
  rect(100+rectLength*3, 215, rectLength, nbPlayers*20);
  fill(0);
  text("Hôtel ", 500, 400);
  rect(100+rectLength*19, 215, rectLength, nbPlayers*20);
  fill(255, 157, 30);
  text("Labyrinthe ", 700, 400);
  rect(100+rectLength*42, 215, rectLength, nbPlayers*20);
  fill(253, 8, 255);
  text("Prison ", 900, 400);
  rect(100+rectLength*52, 215, rectLength, nbPlayers*20);
  fill(0, 157, 255);
  text("Tête de mort ", 1100, 400);
  rect(100+rectLength*58, 215, rectLength, nbPlayers*20);
}

void colorInit() {
  for (int i = 0; i < colors.length; i++) {
    colors[i] = 100 + (int)random(155);
  }
}

void whiteRect(int playerNb) {
  fill(255);
  rect(100+rectLength*position[playerNb], 215+(playerNb*20), rectLength, 20);
}

void coloredRect(int playerNb) {
  fill(colors[playerNb*3], colors[playerNb*3+1], colors[playerNb*3+2]);
  rect(100+rectLength*position[playerNb], 215+(playerNb*20), rectLength, 20);
}

void setup() {
  colorInit();
  initBoardVisual();
  size(1500, 500);
}
