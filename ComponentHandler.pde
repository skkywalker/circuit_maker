public class ComponentHandler {
    public String Name;
    public PVector Size;
    public PShape svg;
    public PVector[] ContactPoints;
    public boolean active = true;

    float SidebarStartPosition;
    float SidebarEndPosition;
    public float SidebarHeight;
    
    public ComponentHandler(String name) {
        Name = name;
        svg = loadShape("data/"+name+".svg");
        Size = new PVector(svg.width, svg.height);
        SidebarHeight = 0.8*SIDEBAR_WIDTH*Size.y/Size.x;
        loadContactPoints();
    }
    
    public ComponentHandler(String name, PVector size) {
        Name = name;
        svg = loadShape("data/"+name+".svg");
        Size = size;
        SidebarHeight = 0.8*SIDEBAR_WIDTH*Size.y/Size.x;
        loadContactPoints();
    }

    private void loadContactPoints() {
        String[] lines = loadStrings(Name+".info");
        ContactPoints = new PVector[lines.length];
        for (int i = 0 ; i < lines.length; i++) {
            String[] parts = lines[i].split("-");
            ContactPoints[i] = new PVector(Size.x*Float.parseFloat(parts[0]),Size.y*Float.parseFloat(parts[1]));
        }
    }
  
    public void updateSidebarPositionY(float SidebarPositionY) {
        SidebarStartPosition = SIDEBAR_STARTING_HEIGHT + SidebarPositionY;
        SidebarEndPosition = SidebarStartPosition+SidebarHeight;
    }

    public boolean sidebarClicked() {
        if(mouseY >= SidebarStartPosition && mouseY <= SidebarEndPosition)
            return true;
        else
            return false;
    }

    public void renderAtSidebar() {
        float sidebarSVGSize = SidebarEndPosition-SidebarStartPosition;
        if(SidebarStartPosition < height && SidebarStartPosition > SIDEBAR_STARTING_HEIGHT-sidebarSVGSize)
            shape(svg, 0.1*SIDEBAR_WIDTH, SidebarStartPosition, 0.8*SIDEBAR_WIDTH, sidebarSVGSize);
    }

    public boolean shouldIBeAtSidebar() {
        if(Name.indexOf(tb.Text) == -1) {
            active = false;
            return false;
        } 
        else {
            active = true;
            return true;
        }
    }
}