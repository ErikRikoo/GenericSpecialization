package test;
class Main {
    static public function main() {
        var a = new BaseClass<String>();
        trace(a.foo("a"));
        var b = new IntSpecialization();
        trace(b.foo(2));

        var a:TestInterface<Int> = new TestInterface<Int>();
        trace(a.foo(2));
    }
}
