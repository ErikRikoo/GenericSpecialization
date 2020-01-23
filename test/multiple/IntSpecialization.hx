package multiple;

import multiple.TestInterface.BaseInterface;

class IntSpecialization implements BaseInterface<Int, Int>{
    public function new() {}

    public function foo(input:Int):Int {
        return input * 2;
    }

    public function foo2(input:Int):Int {
        return input * 4;
    }
}
