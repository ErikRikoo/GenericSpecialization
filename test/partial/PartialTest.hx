package partial;

class PartialTest {
    public function new() {}

    @:describe("Should use the base class if the paramater match no specialization")
    public function useBaseClass() {
        var specialized = new BaseClass<String, Int, Int>();
        var generated = new TestInterface<String, Int, Int>();

        return TestUtil.testTypeEquality(specialized, generated);
    }

    @:describe("Should use the Int,_,_ specialization if Int,Type,Type is given")
    public function usePartial1() {
        var specialized = new PartialImplemenation1<Any, Any>();
        var generated = new TestInterface<Int, Any, Any>();

        return TestUtil.testTypeEquality(specialized, generated);
    }

    @:describe("Should use the Int,Int,Int specialization if Int,Int,Int is given")
    public function useComplete() {
        var specialized = new CompleteImplementation();
        var generated = new TestInterface<Int, Int, Int>();

        return TestUtil.testTypeEquality(specialized, generated);
    }

}
