// Window Dimension
int HEIGHT = 800;
int WIDTH = 1024;

// SearchBox Stuff
int SEARCHBOX_CONTAINER_HEIGHT = 50;
int SIDEBAR_WIDTH = 200;
int SIDEBAR_STARTING_HEIGHT = SEARCHBOX_CONTAINER_HEIGHT;
PVector SEARCHBOX_POSITION = new PVector(10,10);
PVector SEARCHBOX_SIZE = new PVector(SIDEBAR_WIDTH-2*10,SEARCHBOX_CONTAINER_HEIGHT-2*10);
int SIDEBAR_SCROLL_SPEED = 20;

int TOOLBAR_HEIGHT = 50;

// Colors
color RED = color(200,0,0);
color DARKGRAY = color(100);
color LIGHTGRAY = color(240);
color WHITE = color(250);
color BLACK = color(15,15,15);

boolean DRAGGING_STUFF_FLAG = false;
boolean CREATING_WIRE = false;

ComponentHandler[] componentDefinitions;
TextBox tb;
ComponentsList componentsList;
ArrayList<Wire> wireList;
Toolbar toolbar;

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  componentDefinitions = new ComponentHandler[] {
    new ComponentHandler("monumento", new PVector(200,200)),
    new ComponentHandler("circulo", new PVector(200,200)),
    new ComponentHandler("square", new PVector(200,200)),
  };
  tb = new TextBox(SEARCHBOX_POSITION, SEARCHBOX_SIZE);
  componentsList = new ComponentsList();
  wireList = new ArrayList<Wire>();
  toolbar = new Toolbar();
}

void draw() {
  background(WHITE);
    
  componentsList.render();
    
  fill(RED);
  rect(0,0,SIDEBAR_WIDTH, height);
  
  float count = 10;
  for(ComponentHandler ch : componentDefinitions) {
    if(ch.shouldIBeAtSidebar()) {
      ch.updateSidebarPositionY(count);
      count += ch.SidebarHeight + 10;
      ch.renderAtSidebar();
    }
  }

  tb.render();
  for(Wire wire : wireList)
    wire.render();
  toolbar.render();
  handleMouseOverCP();
}

void mousePressed() {
  if(mouseButton == LEFT) {
    if(mouseX > SIDEBAR_WIDTH)
      if(mouseY < TOOLBAR_HEIGHT)
        leftClickAtToolbar();
      else
        leftClickAtCanvas();
    else
      leftClickAtSidebar();
  }
  else if(mouseButton == RIGHT) {
    if(mouseX > SIDEBAR_WIDTH)
      rightClickAtCanvas();
    else
      rightClickAtSidebar();
  }
}

void mouseMoved() {
  for(Component c : componentsList.Loaded) {
    if(c.beingDragged)
      c.setPosition(new PVector(mouseX,mouseY));
  }
}

void mouseWheel(MouseEvent e) {
  SIDEBAR_STARTING_HEIGHT -= SIDEBAR_SCROLL_SPEED*e.getCount();
  if(SIDEBAR_STARTING_HEIGHT > SEARCHBOX_CONTAINER_HEIGHT) SIDEBAR_STARTING_HEIGHT = SEARCHBOX_CONTAINER_HEIGHT;
}

void keyPressed() {
  SIDEBAR_STARTING_HEIGHT = SEARCHBOX_CONTAINER_HEIGHT;
  if(keyCode == TAB) tb.resetText();
  else if(keyCode == ENTER) tb.backspace();
  else tb.addChar(key);
}

void handleMouseOverCP() {
  for(Component c : componentsList.Loaded)
  if(!DRAGGING_STUFF_FLAG) {
      int interceptedCP = c.interceptsContactPoint();
      if(interceptedCP != -1) {
        fill(LIGHTGRAY);
        stroke(BLACK);
        strokeWeight(1);
        circle(c.Position.x+c.ContactPoints[interceptedCP].x,
                c.Position.y+c.ContactPoints[interceptedCP].y, 10);
      }
    }
}