public class RStateController {
  
  RHandState open;
  RHandState closed;
  RHandState lasso;
  
  RHandState rState;
  
  public RStateController() {
    open = new ROpenState(this);
    closed = new RClosedState(this);
    lasso = new RLassoState(this);
    
    rState = open;
  }
  
  void setState(RHandState newRHandState) {
    rState = newRHandState;
  } 
  
  void open() {
    rState.open();
  }
  
  void closed() {
    rState.closed();
  }
  
  void lasso() {
    rState.lasso();
  }
  
  void mouseScroll() {
    if ((currentYPosR - lastYPosR) >= 20) {
      scrollDown();
    } else if ((currentYPosR - lastYPosR) <= -20){
      scrollUp();
    }
    
    lastXPosR = currentXPosR;
    lastYPosR = currentYPosR;
    
  }
}
