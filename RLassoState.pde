public class RLassoState implements RHandState {
  
  RStateController rStateController;
  
  public RLassoState(RStateController newRStateController) {
    rStateController = newRStateController;
  }
  
  @Override
  void open() {    // lasso -> open, TODO
    println("R1");
    ;
    rStateController.setState(rStateController.open);
  }
  
  @Override
  void closed() {  // lasso -> closed, TODO
    println("R2");
    ;
    rStateController.setState(rStateController.closed);
  }
  
  @Override
  void lasso() {  // lasso -> lasso
    println("R3");
    //toggleOSK();
  }
}
