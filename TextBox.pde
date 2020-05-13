class TextBox {
  int TEXT_BLANKSPACE_HEIGHT = 7;
  float textSize;
  color textColor = color(10,10,10);
  color backgroundColor = color(230,230,230);
  
  public String Text = "";
  PVector Position;
  PVector Size;
  
  public TextBox(PVector position, PVector size) {
    Position = position;
    Size = size;
    textSize = Size.y-2*TEXT_BLANKSPACE_HEIGHT;
  }
  
  public void render() {
    fill(RED);
    stroke(RED);
    rect(0, 0, SIDEBAR_WIDTH, SEARCHBOX_CONTAINER_HEIGHT);
    
    fill(backgroundColor);
    rect(Position.x, Position.y, Size.x, Size.y);
    
    fill(textColor);
    textSize(textSize);
    text(Text,Position.x+5,Position.y+Size.y-TEXT_BLANKSPACE_HEIGHT);
  }
  
  public void addChar(char i) {
    Text += i;
  }
  public void backspace() {
    Text = Text.substring(0,Text.length());
  }
  public void resetText() {
    Text = "";
  }
}
