public class LOpenState implements LHandState {
  
  LStateController lStateController;
  
  public LOpenState(LStateController newLStateController) {
    lStateController = newLStateController;
  }
  
  @Override
  void open() {
    println("L1");
    ;
  }
  
  @Override
  void closed() {
    println("L2");
    leftClickDown();
    lStateController.setState(lStateController.closed);
  }
  
  @Override
  void lasso() {
    println("L3");
    lStateController.setState(lStateController.lasso);
    //toggleOSK();
  }
}
