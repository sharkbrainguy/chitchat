Chitchat - Message passing in Javascript
==

Chitchat is an language that runs on javascript and behaves similarly to javascript.

The difference is in that property access and method calls are treated identically i.e. as message passes.

Also, messages to native types are intercepted under certain conditions to make it possible to do certain things:

- Extend native types
- Pass messages to `null`
- Implement `methodMissing` or `doesNotUnderstand` (or whatever it's called) 

The syntax is lispish, because I'm super lazy.

Declaration of locals
--

    (var foo bar baz) ; compiles to `var foo, bar, baz;`

Assignment
--

    (set! foo value) ; compiles to `foo = value`

Message passing
--

    (receiver messageName arg1 arg2 ...)
    (receiver @varContainingMessageName arg1 arg2 ...)
    (receiver @("message" + "Name") arg1 arg2) 

Conditionals
--

    (if a b c) ; compiles to `a ? b : c`
    
    (if a b    ; compiles to `a ? b : c ? d : e`
        c d
        e)

Dot notation
--

    foo.bar.baz             ; is a synonym for to ((foo bar) baz)
    (set! foo.bar baz)      ; is a synonym for (foo set 'bar' baz) 
    (set! foo.bar.baz quuz) ; is a synonym for ((foo bar) set 'baz' quux)
    
Square Bracket notation
--

    foo[0]            ; is a synonym for (foo @0)
    (set! foo[0] bar) ; is a synonym for (foo set 0 bar)
    foo[bar]          ; is a synonym for (foo @bar)

Javascript Keywords 
--

Most javascript keywords are replaced with messages 

    (Foo new)         ; compiles to `new Foo`  
    (Foo new bar baz) ; compiles to `new Foo(bar, baz)`
    
    ;;---------------

    (foo instanceof Bar) ; compiles to `foo instanceof Bar`
    (foo typeof)         ; compiles to `typeof foo`
    (foo isA Bar)        ; do a typecheck through the various layers
    (foo isAn Opera)     ; of indirection I'm slopping all over this thing

Literals
--

Like Javscript, Chitchat provides literals for Arrays, Objects, Strings, Numbers, and Functions.
There are no RegExp literals because I'm too lazy to parse them (maybe you should use coffescript 
I heard that it's actually practical).

    #[1 2 3]          ; [1, 2, 3]
    #{ a 1 b 3 }      ; { a: 1, b: 3 }
    "foo bar"         ; "foo bar"
    "foo 
     bar"             ; "foo\n bar"
    213               ; 213

    ;; Function Literals
    ;; -----------------
    ;;
    ;; These will definitely become lispier
    ;; I have to be able to parse this mess

    ^{ foo }          ; function () { return foo; }
    ^(a b){ (a + b) } ; function (a, b) { return a + b; }
    ^(a b)[ a + b ]   ; function (a, b) { return a + b; }
    #(slice 0 1)      ; synonym for `^(a) [ a slice 0 1 ]`  

    ;; Also I think I'll probably include argument references. Why not

    ^{ (%1 + %2) }    ; function () { return arguments[1] + arguments[2]; }
