package test;

import test.TestInterface.BaseInterface;
class BaseClass<T> implements BaseInterface<T> {
    public function new() {
        trace("New on Base called");
    }

    public function foo(input:T):T  {
        trace("Base called");
        return input;
    }
}
