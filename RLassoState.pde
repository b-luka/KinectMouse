public class RLassoState implements RHandState {
  
  RStateController rStateController;
  
  public RLassoState(RStateController newRStateController) {
    rStateController = newRStateController;
  }
  
  @Override
  void open() {    // lasso -> open, MBM up
    println("R1");
    middleClickUp();
    rStateController.setState(rStateController.open);
  }
  
  @Override
  void closed() {  // lasso -> closed, MBM up
    println("R2");
    middleClickUp();
    rStateController.setState(rStateController.closed);
  }
  
  @Override
  void lasso() {  // lasso -> lasso
    println("R3");
    //toggleOSK();
  }
}
