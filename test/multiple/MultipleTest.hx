package multiple;

import tink.unit.Assert.*;

class MultipleTest {
    public function new() {}

    @:describe("Should use the base class if the paramater match no specialization")
    public function useBaseClass() {
        var specialized = new BaseClass<String, Int>();
        var generated = new TestInterface<String, Int>();

        return TestUtil.testTypeEquality(specialized, generated);
    }

    @:describe("Should use the Int, Int specialization if Int, Int is given as a parameter")
    public function useIntSpecialization() {
        var specialized = new IntSpecialization();
        var generated = new TestInterface<Int, Int>();

        return TestUtil.testTypeEquality(specialized, generated);
    }
}
