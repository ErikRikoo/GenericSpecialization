package test;

@:genericBuild(Builder.build(
    BaseClass,
    [Int => IntSpecialization, ]
))
interface TestInterface<T> extends BaseInterface<T> {

}

interface BaseInterface<T> {
    function foo(input:T):T;
}
