package multiple;


import multiple.TestInterface.BaseInterface;
class BaseClass<T, U> implements BaseInterface<T, U> {
    public function new() {}

    public function foo(input:T):T  {
        return input;
    }

    public function foo2(input:U):U  {
        return input;
    }
}
