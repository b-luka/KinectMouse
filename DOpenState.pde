public class DOpenState implements DHandState {
  
  DStateController dStateController;
  
  public DOpenState(DStateController newDStateController) {
    dStateController = newDStateController;
  }
  
  @Override
  void open() {    // open -> open
    //println("L1");
    ;
  }
  
  @Override
  void closed() {  // open -> closed, LMB down
    //println("L2");
    leftClickDown();
    dStateController.setState(dStateController.closed);
  }
  
  @Override
  void lasso() {   // open -> lasso, toggle OSK
    //println("L3");
    toggleOSK();
    dStateController.setState(dStateController.lasso);
  }
}
