public class RClosedState implements RHandState {
  
  RStateController rStateController;
  
  public RClosedState(RStateController newRStateController) {
    rStateController = newRStateController;
  }
  
  @Override
  void open() {    // closed -> open, RMB up
    println("R1");
    rightClickUp();
    rStateController.setState(rStateController.open);
  }
  
  @Override
  void closed() {  // closed -> closed
    println("R2");
    ;
  }
  
  @Override
  void lasso() {   // closed -> lasso, RMB up
    println("R3");
    rightClickUp();
    rStateController.setState(rStateController.lasso);
    //toggleOSK();
  }
}
