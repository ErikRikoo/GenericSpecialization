package ;

import partial.PartialTest;
import simple.SimpleTest;
import multiple.MultipleTest;
import tink.unit.*;
import tink.testrunner.*;

class Main {
    public static function main():Void {
        Runner.run(TestBatch.make([
//            new SimpleTest(),
//            new MultipleTest(),
            new PartialTest(),
        ]));
    }
}

