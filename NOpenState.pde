public class NOpenState implements NHandState {
  
  NStateController nStateController;
  
  public NOpenState(NStateController newNStateController) {
    nStateController = newNStateController;
  }
  
  @Override
  void open() {    // open -> open
    //println("R1");
    ;
  }
  
  @Override
  void closed() {  // open -> closed, RMB down
    //println("R2");
    rightClickDown();
    nStateController.setState(nStateController.closed);
  }
  
  @Override
  void lasso() {  // open -> lasso, MBM down
    //println("R3");
    middleClickDown();
    nStateController.setState(nStateController.lasso);
    //toggleOSK();
  }
}
