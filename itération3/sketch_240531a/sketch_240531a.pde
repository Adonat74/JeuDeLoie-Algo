int board[] = new int[64];
int position = 0;
int diceResult = 0;
int yAxis = 225;
int xAxis[] = new int[64];
int rectLength = 12;

int diceThrow () {
  int result = ((int)random(6)+1) + ((int)random(6)+1);
  return result;
}

void play() {
  delay(1000);
  fill(255, 0, 0);
  rect(100+rectLength*position, 215, rectLength, 20);
  
  scoreText(diceResult);
  
  diceResult = diceThrow();
  
  position += diceResult;
}

void draw() {
  initBoardVisual();
  if (position == 63) {
    noLoop();
  } else if (position > 63) {
    position = 63 - (position - 63);
    
    play();
  } else {
    
    play();  
  }
}


void initBoardVisual() {
  background(103, 0, 216);
  for (int i = 0; i < board.length; i++) {
    fill(255);
    rect(100+rectLength*i, 215, rectLength, 20); 
  }
}

void scoreText(int result) {
  fill(255);
  textSize(20);
  text("position = " + position, 50, 50);
  text("dice result = " + result, 50, 100);
}


void setup() {
  background(103, 0, 216);
  size(1000, 500);
  for (int i = 0; i < xAxis.length; i++) {
    xAxis[i] = 106 + (i * rectLength);
  }
}
