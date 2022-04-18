# C# notes

Personal notes on C#, especially as it pertains to scripting for Unity.

- [C# notes](#c-notes)
  - [Types](#types)
    - [Classes vs structs](#classes-vs-structs)
    - [Type declaration](#type-declaration)
  - [Data access](#data-access)
  - [Unity event methods](#unity-event-methods)
  - [Debugging](#debugging)

## Types

### Classes vs structs

Csharp has both `classes` (objects/reference type) and `structs` (value type). Value types are allocated on the stack and thus deallocated when the stack unwinds, whereas reference types are allocated on the heap and garbage collected (more expensive). 

However the [.NET docs](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/choosing-between-class-and-struct) recommend using class types in the vast majority of situations, except when instances of the type are small, short-lived and/or commonly embedded in other objects. Ex. `UnityEngine.Quaternion` is a struct.

Value types can be converted or cast into objects and back through `boxing`/`unboxing`.

### Type declaration

 Use var keyboard when the type is explicitly mentioned in the declaration, ex.:
 ```csharp
var time = DateTime.Now;
 ```

### Floats

Game engines (incl. Unity) typically use single-precision floating-point values, ie. `float` rather than `double`.

## Data access

An object's fields should only be modified by other code via `properties`, methods that wrap fields.

## Unity event methods

`Awake`: Invoked when the component is loaded in play mode, once during the script instance's lifetime.
`Update`: Invoked every frame in play mode, before the scene is rendered from the POV of the main camera.

## Debugging

To log to the console: `Debug.Log();`