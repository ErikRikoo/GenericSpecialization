package simple;

import simple.TestInterface.BaseInterface;

class IntSpecialization implements BaseInterface<Int>{
    public function new() {}

    public function foo(input:Int):Int {
        return input * 2;
    }
}
