package multiple;

class Main {
    static public function main() {
        var a = new BaseClass<String, String>();
        trace(a.foo("a"));
        trace(a.foo2("b"));
        var b = new IntSpecialization();
        trace(b.foo(2));
        trace(b.foo2(2));

        var a:TestInterface<Int, Int> = new TestInterface<Int, Int>();
        trace(a.foo(2));
        trace(a.foo2(2));

        var b:TestInterface<String, Int> = new TestInterface<String, Int>();
        trace(b.foo("I am b"));
        trace(b.foo2(10));
    }
}
