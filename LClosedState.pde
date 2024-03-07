public class LClosedState implements LHandState {
  
  LStateController lStateController;
  
  public LClosedState(LStateController newLStateController) {
    lStateController = newLStateController;
  }
  
  @Override
  void open() {    // closed -> open, LMB up
    println("L1");
    leftClickUp();
    lStateController.setState(lStateController.open);
  }
  
  @Override
  void closed() {  // closed -> closed
    println("L2");
    ;
  }
  
  @Override
  void lasso() {  // closed -> lasso, LMB up, toggle OSK
    println("L3");
    leftClickUp();
    toggleOSK();
    lStateController.setState(lStateController.lasso);
  }
}
