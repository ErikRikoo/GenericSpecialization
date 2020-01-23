package multiple;

@:genericBuild(Builder.build(
    BaseClass,
    [Int, Int] => IntSpecialization
))
interface TestInterface<T, U> extends BaseInterface<T, U> {

}

interface BaseInterface<T, U> {
    function foo(input:T):T;
    function foo2(input:U):U;
}
