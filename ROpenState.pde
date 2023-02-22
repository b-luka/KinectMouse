public class ROpenState implements RHandState {
  
  RStateController rStateController;
  
  public ROpenState(RStateController newRStateController) {
    rStateController = newRStateController;
  }
  
  @Override
  void open() {    // open -> open
    println("R1");
    ;
  }
  
  @Override
  void closed() {  // open -> closed, RMB down
    println("R2");
    rightClickDown();
    rStateController.setState(rStateController.closed);
  }
  
  @Override
  void lasso() {  // open -> lasso, TODO
    println("R3");
    rStateController.setState(rStateController.lasso);
    //toggleOSK();
  }
}
