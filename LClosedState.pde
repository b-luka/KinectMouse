public class LClosedState implements LHandState {
  
  LStateController lStateController;
  
  public LClosedState(LStateController newLStateController) {
    lStateController = newLStateController;
  }
  
  @Override
  void open() {
    println("L1");
    leftClickUp();
    lStateController.setState(lStateController.open);
  }
  
  @Override
  void closed() {
    println("L2");
    ;
  }
  
  @Override
  void lasso() {
    println("L3");
    leftClickUp();
    lStateController.setState(lStateController.lasso);
    //toggleOSK();
  }
}
