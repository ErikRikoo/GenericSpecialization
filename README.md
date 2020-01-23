Generic Specialization
===
This library aims to provide an easy way to specialize your generic types.
It is macro based so it works on all platforms.

## Usage
To implement specialization, you need:
- An interface that will use the @:genericBuild
- An interface common to all the types
- A base class that will be used if no valid specialization is called
- Any specialization you need

#### Code:
```haxe
@:genericBuild(Builder.build(
    BaseClass,
    [Int, Int] => CompleteImplementation,
    [Int, _] => PartialImplemenation
))
interface CalledType<T, U> extends BaseInterface<T, U> {}

interface BaseInterface<T, U> {
    // Your methods there
}
```

```haxe
class BaseClass<T, U> implements BaseInterface<T, U> {
    public function new() {}
}
```

```haxe
class CompleteImplementation implements BaseInterface<Int, Int>{
    public function new() {}
}
```

```haxe
class PartialImplemenation<U> implements BaseInterface<Int, U>{
    public function new() {}
}
```

As you can see, there is multiple arguments in the @:genericBuild function:
- BaseClass = the type that will be used when no specialization is matched
- A rest list of arguments, items must follow one of those syntaxes:
    - type => specialization type 
    - [(type|_), ...] => specialization type
        - If a type is given it shuld match with the called type
        - If _ is given any type will match, we kkep the generic on this one

For now you should always have the fullest list at the top to avoid errors.

## To Do
