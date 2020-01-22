package ;

import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
import haxe.macro.Expr.TypePath;
import haxe.macro.Type;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;

using Util;

typedef SpecializationPair = {
    specialized:BaseType,
    specialization:BaseType,
}

class Builder {
    macro static public function build(base:Expr, others:Array<Expr>):ComplexType {
        var instanceParams:Array<Type> = getInstanceParams();
        var baseClass:BaseType = base.toBaseType();
        var specializations:Array<SpecializationPair> = parseOthers(others);

        var currentSpecialization:BaseType = getCurrentSpecialization(instanceParams[0], specializations);
        if(currentSpecialization == null) {
            currentSpecialization = baseClass;
        } else {
            instanceParams = [];
        }

        var tpath:TypePath = {
            name: currentSpecialization.name,
            pack: currentSpecialization.pack,
            params: convertTypeToTypeParam(instanceParams),
        };

        return TPath(tpath);
    }

    private static function getCurrentSpecialization(currentParams:Type, specializations:Array<SpecializationPair>):BaseType {
        for(pair in specializations) {
            if(pair.specialized.equalsByName(currentParams.toBaseType())) {
                return pair.specialization;
            }
        }

        return null;
    }

    private static function getInstanceParams():Array<Type> {
        var type:Null<Type> = Context.getLocalType();
        return switch(type) {
            case TInst(_, p):
                return p;
            default:
                return null;
        };
    }

    private static function convertTypeToTypeParam(params:Array<Type>):Array<TypeParam> {
        var ret:Array<TypeParam> = [];
        for(p in params) {
            var type:BaseType = p.toBaseType();
            ret.push(TPType(TPath({name:type.name, pack:type.pack})));
        }

        return ret;
    }

    private static function parseOthers(others:Array<Expr>):Array<SpecializationPair> {
        var ret = new Array<SpecializationPair>();
        for(other in others) {
            switch(other.expr) {
                case EBinop(OpArrow, _.toBaseType() => specialized, _.toBaseType() => specialization):
                    ret.push({specialized: specialized, specialization: specialization});
                default:
            }
        }

        return ret;
    }
}
