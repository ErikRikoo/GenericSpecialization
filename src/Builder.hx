package ;

import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
import haxe.macro.Expr.TypePath;
import haxe.macro.Type;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;

using Util;

typedef SpecializationPair = {
    specialized:Array<BaseType>,
    specialization:BaseType,
}

class Builder {
    macro static public function build(base:Expr, others:Array<Expr>):ComplexType {
        var instanceParams:Array<Type> = getInstanceParams();
        var baseClass:BaseType = base.toBaseType();
        var specializations:Array<SpecializationPair> = parseOthers(others);

        var currentSpecialization:BaseType = getCurrentSpecialization(instanceParams, specializations);
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

    private static function getCurrentSpecialization(currentParams:Array<Type>, specializations:Array<SpecializationPair>):BaseType {
        for(pair in specializations) {
            if(hasMatching(pair.specialized, currentParams)) {
                return pair.specialization;
            }
        }

        return null;
    }

    private static function hasMatching(looking:Array<BaseType>, instanceParams:Array<Type>) {
        if(looking.length != instanceParams.length) {
            return false;
        }

        for(i in 0...looking.length) {
            if(!looking[i].equalsByName(instanceParams[i].toBaseType())) {
                return false;
            }
        }

        return true;
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
        return params.map((t:Type) -> {
            var baseType:BaseType = t.toBaseType();
            return TPType(TPath({name:baseType.name, pack:baseType.pack}));
        });
    }

    private static function parseOthers(others:Array<Expr>):Array<SpecializationPair> {
        var ret = new Array<SpecializationPair>();
        for(other in others) {
            switch(other.expr) {
                case EBinop(OpArrow, left, _.toBaseType() => specialization):
                    var specialized:Array<BaseType> = [];
                    switch(left.expr) {
                        case EConst(CIdent(s)):
                            specialized.push(s.toBaseType());
                        case EArrayDecl(values):
                            specialized.append(values.toBaseType());
                        default:

                    }

                    ret.push({specialized: specialized, specialization: specialization});
                default:
            }
        }

        return ret;
    }
}
