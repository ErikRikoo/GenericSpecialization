package partial;

class PartialTest {
    public function new() {}

    @:describe("Should use the base class if the paramater match no specialization")
    public function useBaseClass() {
        var specialized = new BaseClass<String, Int, Int>();
        var generated = new TestInterface<String, Int, Int>();

        return TestUtil.testTypeEquality(specialized, generated);
    }

}
