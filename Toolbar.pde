public class Toolbar {
    public IntList Colors;
    public int spacing = 10;
    public int selectedColor = 0;

    public Toolbar() {
        Colors = new IntList(
            RED,
            DARKGRAY,
            BLACK
        );
    }

    public void render() {
        int widthCtrl = SIDEBAR_WIDTH+spacing;
        strokeWeight(1);
        stroke(BLACK);
        fill(LIGHTGRAY);
        rect(SIDEBAR_WIDTH, 0, width-SIDEBAR_WIDTH, TOOLBAR_HEIGHT);
        for(int i = 0; i < Colors.size(); i ++) {
            fill(Colors.get(i));
            if(i == selectedColor) {
                strokeWeight(10);
                stroke(Colors.get(i));
                rect(widthCtrl, spacing, TOOLBAR_HEIGHT-2*spacing,TOOLBAR_HEIGHT-2*spacing);
                stroke(BLACK);
                strokeWeight(1);
            } else {
                rect(widthCtrl, spacing, TOOLBAR_HEIGHT-2*spacing,TOOLBAR_HEIGHT-2*spacing);
            }
            widthCtrl += TOOLBAR_HEIGHT-spacing;
        }
    }

    public color getCurrentColor() {
        return Colors.get(selectedColor);
    }
}