public class NStateController {
  
  NHandState open;
  NHandState closed;
  NHandState lasso;
  
  NHandState nState;
  
  public NStateController() {
    open = new NOpenState(this);
    closed = new NClosedState(this);
    lasso = new NLassoState(this);
    
    nState = open;
  }
  
  void setState(NHandState newNHandState) {
    nState = newNHandState;
  } 
  
  void open() {
    nState.open();
  }
  
  void closed() {
    nState.closed();
  }
  
  void lasso() {
    nState.lasso();
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
