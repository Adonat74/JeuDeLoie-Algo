int nbPlayers = 6;//Nombre de joueurs
int playersPositions[] = new int [nbPlayers];
int playersDiceResult[] = new int [nbPlayers];
int cellWidth = 20;
int[] gooseCells = {9, 18, 27, 36, 45, 54};
int whichPlayerTurn = 0;
int[] playersColors = new int [nbPlayers*3];
boolean isFixedCell = false;
int turn = 1;
int[] playersTimeStuck = new int [nbPlayers];
int whichPlayerInHole = 100;
int whichPlayerInPrison = 100;
boolean isPrisonOccupied = false;

// Un joueur avance par touche pressée
void keyPressed() {
  initBoardVisual();
  checkIsLastPlayer();
  playersTimeStuck[whichPlayerTurn]--;
  
  checkIsLastPlayer();
  
  if (playersTimeStuck[whichPlayerTurn] <= 0 && whichPlayerInHole != whichPlayerTurn && whichPlayerInPrison != whichPlayerTurn) {
    play();
  } else {
    refreshRect(); 
  }
  whichPlayerTurn++;
}

void play() {
  playersDiceResult[whichPlayerTurn] = diceThrow();
  if (!isFixedCell) {
    playersPositions[whichPlayerTurn] += playersDiceResult[whichPlayerTurn];
  }
  checkGooseCells();
  if (playersPositions[whichPlayerTurn] == 63) {
    noLoop();
    scoreFinalDisplay();
  } else if (playersPositions[whichPlayerTurn] > 63) {
    playersPositions[whichPlayerTurn] = 63 - (playersPositions[whichPlayerTurn] - 63);
  }
  checkOtherPositions();
  refreshRect();
}

//simule un lancé de dés
int diceThrow () {
  int dice1 = (int)random(6)+1;
  int dice2 = (int)random(6)+1;
  return checkDicesResult(dice1, dice2);
}

// check si le joueur est le dernier et repasse au premier
void checkIsLastPlayer() {
  if (whichPlayerTurn >= nbPlayers) {
    turn++;
    whichPlayerTurn = 0;
  }
}

// check le résultat des dés pour les règles spéciales
int checkDicesResult (int dice1, int dice2) {
  
  if (turn == 1 && (dice1 == 3 || dice2 == 3) && (dice1 == 6 || dice2 == 6)) {
    playersPositions[whichPlayerTurn] = 26;
    isFixedCell = true;
    return dice1+dice2;
  } else if (turn == 1 && (dice1 == 4 || dice2 == 4) && (dice1 == 5 || dice2 == 5)) {
    playersPositions[whichPlayerTurn] = 53;
    isFixedCell = true;
    return dice1+dice2;
  } else if (turn == 1 && dice1+dice2 == 6) {
    playersPositions[whichPlayerTurn] = 12;
    isFixedCell = true;
    return dice1+dice2;
  }
  isFixedCell = false;
  return dice1+dice2;
}

void checkGooseCells() {
  for (int i = 0; i < gooseCells.length; i++) {
    if (playersPositions[whichPlayerTurn] == gooseCells[i]) {
      playersPositions[whichPlayerTurn] += playersDiceResult[whichPlayerTurn];
    }
  }
}

void checkOtherPositions() {
  
  if(playersPositions[whichPlayerTurn] == 3){
    whichPlayerInHole = whichPlayerTurn;
  } else if (playersPositions[whichPlayerTurn] == 19) {
    
      coloredRect(whichPlayerTurn);
      whiteRect();
      if (playersTimeStuck[whichPlayerTurn] < 0) {
        playersTimeStuck[whichPlayerTurn] = 2;
      }   
    
  } else if (playersPositions[whichPlayerTurn] == 42) {
    playersPositions[whichPlayerTurn] = 30;
  } else if (playersPositions[whichPlayerTurn] == 52) {
    
      if (!isPrisonOccupied) {
        whichPlayerInPrison = whichPlayerTurn;
        isPrisonOccupied = !isPrisonOccupied;
      } else {
        whichPlayerInPrison = 100;
      }
    
  } else if (playersPositions[whichPlayerTurn] == 58) {
    playersPositions[whichPlayerTurn] = 0;
  }
}

//////////////////////////////////////////PARTIE RENDU VISUELLE///////////////////////////////////////////////////////
void scoreTextDisplay(int playerNb) {
  fill(playersColors[playerNb*3], playersColors[playerNb*3+1], playersColors[playerNb*3+2]);
  textSize(25);
  text("position = " + playersPositions[playerNb], 100+(50*(playerNb*4)), 50);
  text("dice result = " + playersDiceResult[playerNb], 100+(50*(playerNb*4)), 100);
}

void scoreFinalDisplay() {
  coloredRect(whichPlayerTurn);
  fill(playersColors[whichPlayerTurn*3], playersColors[whichPlayerTurn*3+1], playersColors[whichPlayerTurn*3+2]);
  textSize(25);
  text("position = " + playersPositions[whichPlayerTurn], 100+(50*(whichPlayerTurn*4)), 50);
  text("dice result = " + playersDiceResult[whichPlayerTurn], 100+(50*(whichPlayerTurn*4)), 100);
}

void initBoardVisual() {
  background(136, 0, 170);
  for (int i = 0; i < 64; i++) {
    fill(255);
    rect(100+cellWidth*i, 215, cellWidth, nbPlayers*20);
    textSize(16);
    text(i, 102+cellWidth*i, 210);
  }
  for (int i = 0; i < gooseCells.length; i++) {
    fill(0, 135, 136);
    textSize(30);
    text("Oies ", 100, 400);
    rect(100+cellWidth*gooseCells[i], 215, cellWidth, nbPlayers*20);
  }
  fill(132, 254, 2);
  text("Puits ", 300, 400);
  rect(100+cellWidth*3, 215, cellWidth, nbPlayers*20);
  fill(0);
  text("Hôtel ", 500, 400);
  rect(100+cellWidth*19, 215, cellWidth, nbPlayers*20);
  fill(255, 157, 30);
  text("Labyrinthe ", 700, 400);
  rect(100+cellWidth*42, 215, cellWidth, nbPlayers*20);
  fill(253, 8, 255);
  text("Prison ", 900, 400);
  rect(100+cellWidth*52, 215, cellWidth, nbPlayers*20);
  fill(0, 157, 255);
  text("Tête de mort ", 1100, 400);
  rect(100+cellWidth*58, 215, cellWidth, nbPlayers*20);
}

void randomColorInit() {
  for (int i = 0; i < playersColors.length; i++) {
    playersColors[i] = 100 + (int)random(155);
  }
}

void refreshRect() {
  for (int i = 0; i < nbPlayers; i++) {
    scoreTextDisplay(i);
    coloredRect(i);
  }
}

void whiteRect() {
  fill(255);
  rect(100+cellWidth*playersPositions[whichPlayerTurn], 215+(whichPlayerTurn*20), cellWidth, 20);
}

void coloredRect(int playerNb) {
  fill(playersColors[playerNb*3], playersColors[playerNb*3+1], playersColors[playerNb*3+2]);
  rect(100+cellWidth*playersPositions[playerNb], 215+(playerNb*20), cellWidth, 20);
}

void pressToPlayText() {
  fill(255);
  text("Appuyez sur n'importe quelle touche pour jouer.", 450, 100);
}

void setup() {
  randomColorInit();
  initBoardVisual();
  pressToPlayText();
  size(1500, 500);
}
void draw() {
}
