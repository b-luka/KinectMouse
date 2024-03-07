public class DStateController {
  
  DHandState open;
  DHandState closed;
  DHandState lasso;
  
  DHandState dState;
  
  public DStateController() {
    open = new DOpenState(this);
    closed = new DClosedState(this);
    lasso = new DLassoState(this);
    
    dState = open;
  }
  
  void setState(DHandState newDHandState) {
    dState = newDHandState;
  } 
  
  void open() {
    dState.open();
  }
  
  void closed() {
    dState.closed();
  }
  
  void lasso() {
    dState.lasso();
  }
}
