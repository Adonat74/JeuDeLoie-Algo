int board[] = new int[64];
int position = 0;

int diceThrow () {
  int result = ((int)random(6)+1) + ((int)random(6)+1);
  return result;
}

void play() {
  int result = diceThrow();
  delay(1000);
  position += result;
  fill(255);
  textSize(20);
  text("pos = " + position, 50, 50);
  text("dice result = " + result, 50, 100);
  fill(255, 0, 0);
  rect(100+12*position, 215, 12, 20);
}

void draw() {
  background(103, 0, 216);
  for (int i = 0; i < board.length; i++) {
    fill(255);
    rect(100+12*i, 215, 12, 20); 
  }
  
  play(); 
  
  if (position > 63) {
     noLoop();
  }
}





void setup() {
  background(103, 0, 216);
  size(1000, 500);
}
