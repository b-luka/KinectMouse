public class DClosedState implements DHandState {
  
  DStateController dStateController;
  
  public DClosedState(DStateController newDStateController) {
    dStateController = newDStateController;
  }
  
  @Override
  void open() {    // closed -> open, LMB up
    //println("L1");
    leftClickUp();
    dStateController.setState(dStateController.open);
  }
  
  @Override
  void closed() {  // closed -> closed
    //println("L2");
    ;
  }
  
  @Override
  void lasso() {  // closed -> lasso, LMB up, toggle OSK
    //println("L3");
    leftClickUp();
    toggleOSK();
    dStateController.setState(dStateController.lasso);
  }
}
