package ;
import haxe.macro.Expr;
import haxe.macro.Type.ClassType;
import haxe.macro.Expr.TypePath;
import haxe.macro.Type;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Context;

using Util.TypeUtil;
using Util.ArrayUtil;
using Util.StringUtil;
using Util.ExprUtil;

class ArrayUtil {
    public static function deepEqual<T>(a:Array<T>, b:Array<T>) {
        if(a.length != b.length) {
            return false;
        }

        for(i in 0...a.length) {
            if(a[i] != b[i]) {
                return false;
            }
        }

        return true;
    }

    public static function toBaseType(a:Array<Expr>) {
        return a.map((e:Expr) -> e.toBaseType());
    }

    public static function append<T>(a:Array<T>, b:Array<T>) {
        for(item in b) {
            a.push(item);
        }
    }
}

class TypeUtil {
    public static function toClassType(input:Type):ClassType {
        switch(input) {
            case TInst(_.get() => cls, _):
                return cls;
            default:
                throw "The given type is not a class instance, type = " + input;
        }
    }

    public static function toBaseType(input:Type):BaseType {
        switch(input) {
            case TInst(_.get() => cls, _):
                return cls;
            case TAbstract(_.get() => type, _):
                return type;
            default:
                throw "The given type does not match the wanted patterns, type = " + input;
        }
    }
}


class ExprUtil {
    public static function toClassType(input:Expr):ClassType {
        switch(input.expr) {
            case EConst(CIdent(s)):
                return Context.getType(s).toClassType();
            default:
                throw "The given expr is not an identifier, expr = " + input;
        }
    }

    public static function toBaseType(input:Expr):BaseType {
        switch(input.expr) {
            case EConst(CIdent(s)):
                return s.toBaseType();
            default:
                throw "The given expr is not an identifier, expr = " + input;
        }
    }
}

class BaseTypeUtil {
    public static function equalsByName(self:BaseType, other:BaseType):Bool {

        return self.name == other.name && self.pack.deepEqual(other.pack);
    }
}

class StringUtil {
    public static function toBaseType(s:String):BaseType {
        return Context.getType(s).toBaseType();
    }
}
