public class ComponentsList {
    public ArrayList<Component> Loaded;
    public IntList markedForDeletion;
    public boolean deleteWires;

    public ComponentsList() {
        markedForDeletion = new IntList();
        Loaded = new ArrayList<Component>();
        deleteWires = true;
    }

    public void NewFromHandler(ComponentHandler ch) {
        Loaded.add(0, new Component(ch.svg, new PVector(mouseX, mouseY), ch.Size, ch.ContactPoints));
    }

    public void NewFromCopy(Component c) {
        Loaded.add(0, c);
    }
    
    public void render() {
        deleteDeletables();

        // First element of the list will be on the front
        for(int i = Loaded.size()-1; i >= 0; i--) {
            Loaded.get(i).render();
        }
    }
  
    private void deleteDeletables() {
        markedForDeletion.sortReverse();
        for(int i : markedForDeletion) {
            if(deleteWires) {
                IntList wiresMarkedForDeletion = new IntList();
                for(int j = 0; j < wireList.size(); j++) {
                    if(wireList.get(j).ParentStart == Loaded.get(i) || wireList.get(j).ParentEnd == Loaded.get(i))
                        wiresMarkedForDeletion.append(j);
                }
                wiresMarkedForDeletion.sortReverse();
                for(int k : wiresMarkedForDeletion)
                    wireList.remove(k);
            }
            Loaded.remove(i);
        }
        markedForDeletion = new IntList();
        deleteWires = true;
    }
}