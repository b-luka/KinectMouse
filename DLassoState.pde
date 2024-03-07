public class DLassoState implements DHandState {
  
  DStateController dStateController;
  
  public DLassoState(DStateController newDStateController) {
    dStateController = newDStateController;
  }
  
  @Override
  void open() {    // lasso -> open, toggle OSK
    //println("L1");
    dStateController.setState(dStateController.open);
  }
  
  @Override
  void closed() {  // lasso -> closed
    //println("L2");
    dStateController.setState(dStateController.closed);
  }
  
  @Override
  void lasso() {  // lasso -> lasso
    //println("L3");
    //toggleOSK();
  }
}
