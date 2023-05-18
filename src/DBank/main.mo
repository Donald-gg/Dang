import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {

  // var currentValue: Nat = 300; // flexible variable
  stable var currentValue : Float = 100; // persistent variable
  // update call
  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  // update call
  public func withdraw(amount : Float) {
    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Operation not permitted");
    };
  };

  // query call
  public query func checkBalance() : async Float {
    return currentValue;
  };

  stable var now = Time.now();
  public func compound() {
    let timeElapsedSinceDeploy = (Time.now() - now) / 1000000000;
    currentValue := currentValue * (1.001 ** Float.fromInt(timeElapsedSinceDeploy));
    Debug.print(debug_show (timeElapsedSinceDeploy));
    now := Time.now();
  };
};
