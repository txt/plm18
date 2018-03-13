
[home](http://tiny.cc/plm18) |
[copyright](https://github.com/txt/plm18/blob/master/LICENSE.md) &copy;2018, tim&commat;menzies.us
<br>
[<img width=900 src="https://raw.githubusercontent.com/txt/plm18/master/img/banner.png">](http://tiny.cc/plm18)<br>
[syllabus](https://github.com/txt/plm18/blob/master/doc/syllabus.md) |
[src](https://github.com/txt/plm18/tree/master/src) |
[submit](http://tiny.cc/plm18give) |
[chat](https://plm18.slack.com/)


______



# Semantics: 21st century Lambda Bodies

Introducing Clojure

- Clojure is a new functional language written specifically for the JVM.
- Clojure is a variation of LISP that brings functional languages concepts to the JVM. Clojure also integrates well with Java code, so it can take advantage of the huge number of Java libraries.
- Clojure provides many useful features, but in this article, we will look at just one: immutability.

## Benefits of Immutability

In Clojure, immutability is the default. Once an object or data structure is created, it cannot be changed. This provides many benefits:

- Understanding
     - As mentioned above, mutability makes it much harder to reason about and understand programs, because any object passed to a method could get changed under the covers.
In an immutable system, however, one only needs to understand the input and output values passed to a function to reason about its behavior.
- Testability
    - Since the set of possible states and transitions is much smaller, an immutable system is easier to fully test.
Invariants
Since an object cannot change once constructed, invariants can be enforced when an object is constructed and never need to be checked again.
Once you validate that an object is constructed in a valid state, you never need to validate it again – it can never become invalid.
- Equality
    - Testing two mutable objects for equality is illusory, since, while they might be equal now, they could become unequal later if a property of one of the objects changes.
If two immutable objects are equal, they will always be equal.
- Cheap Sharing
    - In Java, one often makes defensive copies of objects to prevent errors when a shared object reference is changed.
In Clojure, object references can be safely shared, since they can never change. We can more aggressively intern objects and implement memory-saving techniques, like the flyweight pattern.
- Concurrency
     - Immutable objects are thread-safe by definition. If an object cannot be changed, it can be shared among different concurrent threads without concurrent modification exceptions.

##  Look Ma, No Variables!

While there are many benefits to pervasive immutability, it does require different programming styles. It takes some getting used to.

As we know, the for loop form in Java is syntactic sugar for something like this:

```java
          public void greetingsFromSanta() {
                int i = 0;
                while (i < n) {
                    System.out.print("Ho! ");
                    i = i + 1;
                }
            }
```

The i variable is incremented and then assigned back to itself. The value of i is not constant; it's variable.

How could we write such a method without incrementing the i variable?

Traditionally in functional programming languages such as Scheme and Lisp, this sort of thing is done using recursion. We could write a similar function in Clojure as follows:

```clojure
            (defn greetings-from-santa [n]
                (if (> n 0)
                    (do
                        (print "Ho! ")
                        (greetings-from-santa (dec n)))))
```
