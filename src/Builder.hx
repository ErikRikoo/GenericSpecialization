package ;
import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
import haxe.macro.Expr.TypePath;
import haxe.macro.Type;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;

class Builder {
    macro static public function build(base:Expr, others:Expr):ComplexType {
        trace("------ Builder Called ------");
//        trace(base);
//        trace(others);
        var type:Null<Type> = Context.getLocalType();
        var instanceParams:Array<TypeParam>;
        switch(type) {
            case TInst(_, p):
                instanceParams = convert(p);
            default:

        }
//        trace(type);
        var baseType:Type;
        var baseClass:ClassType;
        var params:Array<Type>;
        switch(base.expr) {
            case EConst(CIdent(s)):
                baseType = Context.getType(s);
//                trace(baseType);
                switch(baseType) {
                    case TInst(cls, p):
                        baseClass = cls.get();
                        params = p;
                    default:
                }
            default:
        }

//        trace(baseClass);
//        trace(params);
        var self:ClassType = Context.getLocalClass().get();
//        trace(self);
        var tpath:TypePath = {
            name: baseClass.name,
            pack : baseClass.pack,
            params: instanceParams,
        };

        return TPath(tpath);
    }

    private static function convert(params:Array<Type>):Array<TypeParam> {
        var ret:Array<TypeParam> = [];
        for(p in params) {
            switch(p) {
                case TAbstract(_.get() => t, _):
                    ret.push(TPType(TPath({name:t.name, pack:t.pack})));
                default:

            }
        }

        return ret;
    }
}
