public class LStateController {
  
  LHandState open;
  LHandState closed;
  LHandState lasso;
  
  LHandState lState;
  
  public LStateController() {
    open = new LOpenState(this);
    closed = new LClosedState(this);
    lasso = new LLassoState(this);
    
    lState = open;
  }
  
  void setState(LHandState newLHandState) {
    lState = newLHandState;
  } 
  
  void open() {
    lState.open();
  }
  
  void closed() {
    lState.closed();
  }
  
  void lasso() {
    lState.lasso();
  }
}
