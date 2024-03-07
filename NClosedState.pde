public class NClosedState implements NHandState {
  
  NStateController nStateController;
  
  public NClosedState(NStateController newNStateController) {
    nStateController = newNStateController;
  }
  
  @Override
  void open() {    // closed -> open, RMB up
    //println("R1");
    rightClickUp();
    nStateController.setState(nStateController.open);
  }
  
  @Override
  void closed() {  // closed -> closed
    //println("R2");
    ;
  }
  
  @Override
  void lasso() {   // closed -> lasso, RMB up, MBM down
    //println("R3");
    rightClickUp();
    middleClickDown();
    nStateController.setState(nStateController.lasso);
    //toggleOSK();
  }
}
