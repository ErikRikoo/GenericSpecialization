package test;
import test.TestInterface.BaseInterface;
class IntSpecialization implements BaseInterface<Int>{
    public function new() {
    }

    public function foo(input:Int):Int {
        trace("Int called");
        return input * 2;
    }
}
