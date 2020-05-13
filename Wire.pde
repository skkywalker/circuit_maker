public class Wire {
    public ArrayList<PVector> Waypoints;
    public int ContactPointStartIndex;
    public int ContactPointEndIndex;
    public boolean Defined;
    color Color;
    
    public Component ParentStart;
    public Component ParentEnd;

    public Wire(Component parent, int index, color c) {
        ParentStart = parent;
        ContactPointStartIndex = index;
        Defined = false;
        Waypoints = new ArrayList<PVector>();
        Color = c;
    }

    public void SetEndParent(Component endP, int endI) {
        ParentEnd = endP;
        ContactPointEndIndex = endI;
    }

    public void render() {
        PVector endPoint;
        PVector startPoint = ParentStart.ContactPoints[ContactPointStartIndex].copy().add(ParentStart.Position);
        if(Defined) endPoint = ParentEnd.ContactPoints[ContactPointEndIndex].copy().add(ParentEnd.Position);
        else endPoint = new PVector(mouseX,mouseY);

        stroke(Color);
        fill(Color);
        strokeWeight(6);
        if(Waypoints.size() == 0) {
            drawLine(startPoint, endPoint);
            strokeWeight(0);
            drawCircle(startPoint);
            drawCircle(endPoint);
        } else {
            drawLine(startPoint, Waypoints.get(0));
            int i = 0;
            for(i = 0; i < Waypoints.size()-1; i++) {
                drawLine(Waypoints.get(i), Waypoints.get(i+1));
            }
            drawLine(Waypoints.get(i), endPoint);
            strokeWeight(0);
            drawCircle(startPoint);
            i = 0;
            for(i = 0; i < Waypoints.size(); i++) {
                drawCircle(Waypoints.get(i));
            }
            drawCircle(endPoint);
        }
    }
}

void drawLine(PVector start, PVector finish) {
    line(start.x,start.y,finish.x,finish.y);
}

void drawCircle(PVector center) {
    circle(center.x,center.y,10);
}