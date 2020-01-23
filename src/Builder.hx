package ;

import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
import haxe.macro.Expr.TypePath;
import haxe.macro.Type;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;

using Util;

typedef SpecializationPair = {
    specialized:Array<Mask>,
    specialization:BaseType,
}

typedef GenericType = {
    type:BaseType,
    params:Array<BaseType>
}

enum Mask {
    Typed(t:BaseType);
    AnyType();
}

enum ReturnValue<T> {
    Value(v:T);
    Invalid();
}

class Builder {
    macro static public function build(base:Expr, others:Array<Expr>):ComplexType {
        var instanceParams:Array<BaseType> = getInstanceParams();
        var baseClass:BaseType = base.toBaseType();
        var specializations:Array<SpecializationPair> = parseOthers(others);
        var tpath:TypePath = getSpecialization(instanceParams, specializations, baseClass);
        return TPath(tpath);
    }

    private static function getSpecialization(
        currentParams:Array<BaseType>, specializations:Array<SpecializationPair>,
        base:BaseType
        ):TypePath {
        for(pair in specializations) {
            switch(getMatching(pair.specialized, currentParams)) {
                case Value(p):
                    return {
                        name: pair.specialization.name,
                        pack: pair.specialization.pack,
                        params: convertTypeToTypeParam(p),
                    }
                default:
            }
        }

        return {
            name: base.name,
            pack: base.pack,
            params: convertTypeToTypeParam(currentParams)
        };
    }

    private static function getMatching(specialized:Array<Mask>, current:Array<BaseType>):ReturnValue<Array<BaseType>> {
        if(specialized.length != current.length) {
            return Invalid;
        }

        var ret:Array<BaseType> = [];
        for(i in 0...specialized.length) {
            var spe = specialized[i];
            var cur = current[i];
            switch(spe) {
                case AnyType:
                    ret.push(cur);
                case Typed(t) if(!t.equalsByName(cur)):
                    return Invalid;
                default:
            }
        }

        return Value(ret);
    }

    private static function getInstanceParams():Array<BaseType> {
        return switch(Context.getLocalType()) {
            case TInst(_, p):
                return p.map((t:Type) -> t.toBaseType());
            default:
                return null;
        };
    }

    private static function convertTypeToTypeParam(params:Array<BaseType>):Array<TypeParam> {
        return params.map((t:BaseType) -> {
            return TPType(TPath({name:t.name, pack:t.pack}));
        });
    }

    private static function parseOthers(others:Array<Expr>):Array<SpecializationPair> {
        var ret = new Array<SpecializationPair>();
        for(other in others) {
            switch(other.expr) {
                case EBinop(OpArrow, left, _.toBaseType() => specialization):
                    var specialized:Array<Mask>;
                    switch(left.expr) {
                        case EConst(CIdent(_.toBaseType() => t)):
                            specialized = [Typed(t)];
                        case EArrayDecl(values):
                            specialized = toMask(values);
                        default:

                    }

                    ret.push({specialized: specialized, specialization: specialization});
                default:
            }
        }

        return ret;
    }

    private static function toMask(values:Array<Expr>):Array<Mask> {
        return values.map((e:Expr) -> {
            return switch(e.expr) {
                case EConst(CIdent("_")):
                    AnyType;
                case EConst(CIdent(_.toBaseType() => t)):
                    Typed(t);
                default:
                    throw "Unmatched expression: " + e;
            };
        });
    }
}
