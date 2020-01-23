package ;

import tink.testrunner.Assertion;
import tink.unit.Assert;

class TestUtil {
    public static function testTypeEquality(a:Dynamic, b:Dynamic) {
        var typeOfA = Type.typeof(a);
        var typeOfB = Type.typeof(b);

        return new Assertion(Type.enumEq(typeOfA, typeOfB), "The values have the same type");
    }
}
