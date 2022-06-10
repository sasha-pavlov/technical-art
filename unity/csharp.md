# Csharp notes

Personal notes on C#, especially w/r/t scripting for Unity.

- [C# notes](#c-notes)
  - [Types](#types)
    - [Classes vs structs](#classes-vs-structs)
    - [Type declaration](#type-declaration)
    - [Floats](#floats)
  - [Data access](#data-access)
  - [Unity event methods](#unity-event-methods)
  - [Loops](#loops)
  - [Debugging](#debugging)

## Types

### Classes vs structs

Csharp has both `classes` (objects/reference type) and `structs` (value type). Value types are allocated on the stack and thus deallocated when the stack unwinds, whereas reference types are allocated on the heap and garbage collected (more expensive).

However the [.NET docs](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/choosing-between-class-and-struct) recommend using class types in the vast majority of situations, except when instances of the type are small, short-lived and/or commonly embedded in other objects. Ex. `UnityEngine.Quaternion` is a struct.

Structs should generally be immutable, like simple values, but Unity's `Vector` types are mutable for convenience/efficiency.

Value types can be converted or cast into objects and back through `boxing`/`unboxing`.

### Type declaration

Use var keyboard when the type is explicitly mentioned in the declaration, ex.:

```csharp
var time = DateTime.Now;
```

### Floats

Game engines (incl. Unity) typically use single-precision floating-point values, ie. `float` rather than `double`.

## Arrays

Arrays are objects, thus they must be instantiated (with a determined length) and are passed-by-reference.

```csharp
Transform[] assets;
void Awake() { assets = new Transform[10]; }
```

## Assignment

On top of performing the assignment, an assignment expression actually returns what was assigned. Thus assignments can be used in larger expressions, ex. assignment chaining:

```csharp
Transform asset = assets[i] = Instantiate(prefab);
asset.localPosition = position;
// asset[i] contains the same ref; also updates
```

### Setting properties

An object's fields should only be modified by other code via `properties`, methods that wrap fields.

Properties can't be directly reevaluated. Ex. the following code won't work:

```csharp
asset.localPosition.x++;
```

`localPosition` is a `property`, a collection of methods that get and set copies of the field's actual value. To increment a property, the value must be gotten, incremented, and finally used to set the property:

```csharp
Vector3 position = asset.localPosition;
position++;
asset.localPosition = position;
```

## Unity event methods

`Awake`: Invoked when the component is loaded in play mode, once during the script instance's lifetime. Instantiate initial scene objects here.
`Update`: Invoked every frame in play mode, before the scene is rendered from the POV of the main camera.

## Loops

Variables declared within a loop only get defined once, and are automatically reassigned thereafter. Thus it is memory-safe to declare loop-scoped vars.

**Incrementing**: `++i` increments first in the expression, `i++` increments last.

## Debugging

To log to the console: `Debug.Log();`
