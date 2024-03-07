public class LOpenState implements LHandState {
  
  LStateController lStateController;
  
  public LOpenState(LStateController newLStateController) {
    lStateController = newLStateController;
  }
  
  @Override
  void open() {    // open -> open
    println("L1");
    ;
  }
  
  @Override
  void closed() {  // open -> closed, LMB down
    println("L2");
    leftClickDown();
    lStateController.setState(lStateController.closed);
  }
  
  @Override
  void lasso() {   // open -> lasso, toggle OSK
    println("L3");
    toggleOSK();
    lStateController.setState(lStateController.lasso);
  }
}
