public class Component {
  PVector Position;
  PVector Size;
  PShape Svg;
  public PVector[] ContactPoints;
  PVector MoveStartingPoint;
  PVector DistanceFromCenterOnMove = new PVector(0,0);
  public boolean beingDragged = true;

  public Component(PShape svg, PVector position, PVector size, PVector[] cp) {
    Position = position;
    Svg = svg;
    Size = size;
    ContactPoints = cp;
    MoveStartingPoint = position.sub(new PVector(Size.x/2,Size.y/2));
  }
  
  public void render() {
    shape(Svg, Position.x, Position.y, Size.x, Size.y);
    fill(LIGHTGRAY);
    stroke(BLACK);
    strokeWeight(1);
    for(PVector cp : ContactPoints)
      circle(Position.x+cp.x,Position.y+cp.y, 5);
  }
  
  public void setPosition(PVector pos) {
    PVector move = new PVector(pos.x - MoveStartingPoint.x - Size.x/2 - DistanceFromCenterOnMove.x,
      pos.y - MoveStartingPoint.y - Size.y/2 - DistanceFromCenterOnMove.y);
    Position = MoveStartingPoint.add(move);
  }
  
  public int interceptsContactPoint() {
    for(int i = 0; i < ContactPoints.length; i++) {
      if(Math.abs(mouseX-Position.x-ContactPoints[i].x) < 9 && Math.abs(mouseY-Position.y-ContactPoints[i].y) < 9)
        return i;
    }
    return -1;
  }
  
  public boolean isUnderMouse() {
    boolean containedX = (mouseX >= Position.x && mouseX <= Position.x + Size.x);
    boolean containedY = (mouseY >= Position.y && mouseY <= Position.y + Size.y);
    return (containedX && containedY);
  }
  
  public void startMovement() {
    beingDragged = true;
    DistanceFromCenterOnMove = new PVector(mouseX-Position.x-Size.x/2,mouseY-Position.y-Size.y/2);
  }
  
  public void stopMovement() {
    beingDragged = false;
    DistanceFromCenterOnMove = new PVector(0,0);
  }
}
