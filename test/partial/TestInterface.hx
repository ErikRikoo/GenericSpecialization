package partial;

@:genericBuild(Builder.build(
    BaseClass
))
interface TestInterface<T, U, V> extends BaseInterface<T, U, V> {

}

interface BaseInterface<T, U, V> {

}
