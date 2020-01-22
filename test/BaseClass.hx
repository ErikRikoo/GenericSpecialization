package ;

import TestInterface.BaseInterface;

class BaseClass<T> implements BaseInterface<T> {
    public function new() {}

    public function foo(input:T):T  {
        return input;
    }
}
