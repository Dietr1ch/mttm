# API Reference

> **Audience:** Developers integrating this library.
> This document covers all public types, functions, and traits.

## `ModuleName`

### `function_name(param1: Type1, param2: Type2) -> ReturnType`

<!-- One-line description of what the function does. -->

**Parameters:**

| Name     | Type    | Description                     |
|----------+---------+---------------------------------|
| `param1` | `Type1` | What this parameter is for.     |
| `param2` | `Type2` | What this parameter is for.     |

**Returns:**

<!-- Description of the return value. -->

**Errors:**

<!-- When and why this function can fail. -->

**Example:**

```rust
use crate::function_name;

let result = function_name("hello", 42);
assert_eq!(result, "expected output");
```

---

### `StructName`

<!-- Description of the struct and its purpose. -->

**Fields:**

| Name   | Type    | Description               |
|--------+---------+---------------------------|
| `field` | `Type` | What this field holds.   |

**Example:**

```rust
let instance = StructName { field: value };
```

---

### `TraitName`

<!-- Description of the trait. -->

**Methods:**

- `method_name(self, arg: Type) -> ReturnType` — description

**Implementors:**

- `StructName`
