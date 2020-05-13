void leftClickAtCanvas()  {
  if(DRAGGING_STUFF_FLAG) {
    for(Component c : componentsList.Loaded) {
      if(c.beingDragged) {
        c.stopMovement();
        DRAGGING_STUFF_FLAG = false;
        return;
      }
    }
  }
  int contactPointIndex;
  boolean flagForFinishWire = false;
  for(Component c : componentsList.Loaded)
    if(c.interceptsContactPoint() != -1 && CREATING_WIRE) {
      flagForFinishWire = true;
    }
  for(Component c : componentsList.Loaded) {
    contactPointIndex = c.interceptsContactPoint();
    if(contactPointIndex == -1) {
      if(CREATING_WIRE && !flagForFinishWire) {
        wireList.get(wireList.size()-1).Waypoints.add(new PVector(mouseX, mouseY));
        continue;
      }
      if(c.isUnderMouse()) {
        c.startMovement();
        DRAGGING_STUFF_FLAG = true;
        break;
      }
    }
    else {
      if(CREATING_WIRE) {
        wireList.get(wireList.size()-1).SetEndParent(c,contactPointIndex);
        CREATING_WIRE = false;
        wireList.get(wireList.size()-1).Defined = true;
      } else {
        wireList.add(new Wire(c, contactPointIndex, toolbar.getCurrentColor()));
        CREATING_WIRE = true;
      }
      break;
    }
  }
}

void leftClickAtSidebar() {
  if(CREATING_WIRE) return;
  if(mouseY > SEARCHBOX_CONTAINER_HEIGHT){
    for(int i = 0; i < componentsList.Loaded.size(); i++) {
      if(componentsList.Loaded.get(i).beingDragged) {
        componentsList.markedForDeletion.append(i);
        return;
      }
    }
    for(ComponentHandler ch : componentDefinitions) {
      if(ch.sidebarClicked() && ch.active) {
        componentsList.NewFromHandler(ch);
        DRAGGING_STUFF_FLAG = true;
      }
    }
  }
}

void rightClickAtCanvas() {
  if(CREATING_WIRE) return;
  if(DRAGGING_STUFF_FLAG) return;
  for(int i = 0; i < componentsList.Loaded.size(); i++) {
    if(componentsList.Loaded.get(i).isUnderMouse()) {
      componentsList.deleteWires = false;
      componentsList.NewFromCopy(componentsList.Loaded.get(i));
      componentsList.markedForDeletion.append(i+1);
      for(Wire w : wireList) {
        if(w.ParentStart == componentsList.Loaded.get(i+1))
          w.ParentStart = componentsList.Loaded.get(0);
        if(w.ParentEnd == componentsList.Loaded.get(i+1))
          w.ParentEnd = componentsList.Loaded.get(0);
      }
      break;
    }
  }
}

void rightClickAtSidebar() {
  
}

void leftClickAtToolbar() {
  float verificationStart = SIDEBAR_WIDTH + toolbar.spacing;
  int colorWidth = TOOLBAR_HEIGHT-2*toolbar.spacing;
  for(int i = 0; i < toolbar.Colors.size(); i ++) {
    if(mouseX < verificationStart+colorWidth && mouseX > verificationStart) {
      toolbar.selectedColor = i;
      print(toolbar.selectedColor);
      return;
    }
    verificationStart += (colorWidth + toolbar.spacing);
  }
  print(toolbar.selectedColor);
  return;
}