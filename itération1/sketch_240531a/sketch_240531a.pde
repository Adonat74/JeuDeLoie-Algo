int board[] = new int[64];

int position = 0;

int diceThrow () {
  int result = ((int)random(6)+1) + ((int)random(6)+1);
  return result;
}

void play() {
  while (position < 63) {
    int result = diceThrow();
    position += result;
    print("dice result = " + result);
    println(" pos = " + position); 
  }
}



void setup() {
  play(); 
}
