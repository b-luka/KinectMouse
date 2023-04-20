public class NLassoState implements NHandState {
  
  NStateController nStateController;
  
  public NLassoState(NStateController newNStateController) {
    nStateController = newNStateController;
  }
  
  @Override
  void open() {    // lasso -> open, MBM up
    //println("R1");
    middleClickUp();
    nStateController.setState(nStateController.open);
  }
  
  @Override
  void closed() {  // lasso -> closed, MBM up
    //println("R2");
    middleClickUp();
    nStateController.setState(nStateController.closed);
  }
  
  @Override
  void lasso() {  // lasso -> lasso
    //println("R3");
    //toggleOSK();
  }
}
