package simple;

import tink.unit.Assert.*;

class SimpleTest {
    public function new() {}

    @:describe("Should use the base class if the paramater match no specialization")
    public function useBaseClass() {
        var specialized = new BaseClass<String>();
        var generated = new TestInterface<String>();

        return TestUtil.testTypeEquality(specialized, generated);
    }

    @:describe("Should use the Int specialization if Int is given as a parameter")
    public function useIntSpecialization() {
        var specialized = new IntSpecialization();
        var generated = new TestInterface<Int>();

        return TestUtil.testTypeEquality(specialized, generated);
    }
}
