public class LLassoState implements LHandState {
  
  LStateController lStateController;
  
  public LLassoState(LStateController newLStateController) {
    lStateController = newLStateController;
  }
  
  @Override
  void open() {
    println("L1");
    toggleOSK();
    lStateController.setState(lStateController.open);
  }
  
  @Override
  void closed() {
    println("L2");
    toggleOSK();
    lStateController.setState(lStateController.closed);
  }
  
  @Override
  void lasso() {
    println("L3");
    //toggleOSK();
  }
}
