package partial;

@:genericBuild(Builder.build(
    BaseClass,
    [Int, _, _] => PartialImplemenation1
))
interface TestInterface<T, U, V> extends BaseInterface<T, U, V> {

}

interface BaseInterface<T, U, V> {

}
