public class LLassoState implements LHandState {
  
  LStateController lStateController;
  
  public LLassoState(LStateController newLStateController) {
    lStateController = newLStateController;
  }
  
  @Override
  void open() {    // lasso -> open, toggle OSK
    println("L1");
    toggleOSK();
    lStateController.setState(lStateController.open);
  }
  
  @Override
  void closed() {  // lasso -> closed, toggle OSK
    println("L2");
    toggleOSK();
    lStateController.setState(lStateController.closed);
  }
  
  @Override
  void lasso() {  // lasso -> lasso
    println("L3");
    //toggleOSK();
  }
}
