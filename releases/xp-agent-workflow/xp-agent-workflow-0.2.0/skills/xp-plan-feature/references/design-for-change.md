# Design For Change

Refactor tasks exist to make the next behavior change easy. They should be motivated by a concrete design pressure, not by abstract cleanliness.

## Good Refactor Motivations

- The test is hard to write because dependencies are hidden or global.
- The behavior belongs behind an interface or port.
- The code duplicates a concept that is about to change in multiple places.
- The domain language is implicit or scattered.
- Primitive values carry domain meaning without names or invariants.
- A function has too many parameters or mixes unrelated concepts.
- A module has more than one reason to change.
- A side effect is mixed into pure decision logic.
- Existing abstractions point the wrong direction for the new behavior.

## Design Heuristics

- SOLID: separate responsibilities, depend on abstractions at boundaries, keep substitutions honest.
- Domain-driven design: name domain concepts explicitly and keep behavior near the concept it belongs to.
- DRY: remove meaningful duplication after the second real example, not before the first.
- Dependency inversion: push volatile infrastructure behind stable ports.
- Immutability: prefer explicit value transitions over hidden mutation.
- Value objects: replace primitive obsession with named immutable domain values when the value has invariants or behavior.
- Ports and adapters: isolate external systems, UI, databases, and network calls from domain decisions.

## Planning Rule

Only add a REFACTOR task when it directly reduces risk or friction for a following BEHAVIOR CHANGE task, or when the requested work is explicitly refactor-only.
