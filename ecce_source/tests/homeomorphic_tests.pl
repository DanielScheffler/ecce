:- module(homeomorphic_tests, [run_homeomorphic/2]).

:- use_module(library(plunit)).
:- use_module('../homeomorphic').

:- begin_tests(homeomorphic_embedded_conjunction).

    test(homeomorphic_embedded_conjunction1, [fail]) :-
        homeomorphic_embedded_conjunction([a,q(X,Y)],[s,q(Y,f(X)),p,f(a),q(a,b)]).

    test(homeomorphic_embedded_conjunction2) :-
        homeomorphic_embedded_conjunction([q(X,Y)],[q(Y,f(X))]).

    test(homeomorphic_embedded_conjunction3) :-
        homeomorphic_embedded_conjunction([a,q(X,_Y)],[s,f(a),q(_Y,f(X)),p]).

    test(homeomorphic_embedded_conjunction4) :-
        homeomorphic_embedded_conjunction([q(1,2),q(X,Y)],[q(1,2),q(2,3),q(f(1),f(2)),f(a),q(Y,f(X)),p]).

    test(homeomorphic_embedded_conjunction5) :-
        homeomorphic_embedded_conjunction([],[s,f(a),q(_Y,f(_X)),p]).

    test(homeomorphic_embedded_conjunction6) :-
        homeomorphic_embedded_conjunction([q(X,Y)],[q(X,Y)]).

    test(homeomorphic_embedded_conjunction7) :-
        homeomorphic_embedded_conjunction([q(a,Y)],[q(b,Y),q(c,Y),q(a,Y)]).

    test(homeomorphic_embedded_conjunction8) :-
        homeomorphic_embedded_conjunction([q(a,Y)],[q(b,Y),q(a,Y),q(c,Y)]).

:- end_tests(homeomorphic_embedded_conjunction).

:- begin_tests(homeomorphic_embedded).

    test(homeomorphic_embedded1, [fail]) :-
        homeomorphic_embedded(p(f(a)),p(a)).

    test(homeomorphic_embedded2, [fail]) :-
        homeomorphic_embedded(p(a),p(_X)).

    test(homeomorphic_embedded3, [fail]) :-
        homeomorphic_embedded(p(a),p(p(f(g(b,c))))).

    test(homeomorphic_embedded4, [fail]) :-
        homeomorphic_embedded(f(a,b),f(g(a,b),c)).

    test(homeomorphic_embedded5) :-
        homeomorphic_embedded(a,f(a)).

    test(homeomorphic_embedded6) :-
        homeomorphic_embedded(f(X),f(X)).

    test(homeomorphic_embedded7) :-
        homeomorphic_embedded(f(X,Y),f(Y,X)).

    test(homeomorphic_embedded8) :-
        homeomorphic_embedded(f(X,Y),f(Y,s(X))).

    test(homeomorphic_embedded9) :-
        homeomorphic_embedded(f(a,_Y),f([c,b,a],s(_X))).

    test(homeomorphic_embedded10) :-
        homeomorphic_embedded(f(f(a)),f(f(a))).

    test(homeomorphic_embedded11) :-
        homeomorphic_embedded(q(b),q(1,2,q(f(1,f(b,2,3),3)))).

    test(homeomorphic_embedded12) :-
        homeomorphic_embedded(q(b),q(1,q(b),b)).

    test(homeomorphic_embedded13) :-
        homeomorphic_embedded(q(X),f(a,q(s(X)))).

    test(homeomorphic_embedded14) :-
        homeomorphic_embedded(p(1,2,f(3)),p(1,p(s(a,1),f(f(2)),g(a,b,f(3))),3)).

    test(homeomorphic_embedded15) :-
        homeomorphic_embedded(q(_X,Y),q(Y,f(_X))).

:- end_tests(homeomorphic_embedded).

run_homeomorphic(Passed, Failed) :-
    run_tests([homeomorphic_embedded_conjunction,homeomorphic_embedded], [passed(Passed), failed(Failed)]).