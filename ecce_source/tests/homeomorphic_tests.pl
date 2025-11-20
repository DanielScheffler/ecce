:- module(homeomorphic_tests, [run_homeomorphic_tests/0]).

:- use_module(library(plunit)).
:- use_module('../homeomorphic').

:- begin_tests(homeomorphic_embedded_conjunction).

    test(homeomorphic1, [fail]) :-
        homeomorphic_embedded_conjunction([a,q(X,Y)],[s,q(Y,f(X)),p,f(a),q(a,b)]).

    test(homeomorphic2) :-
        homeomorphic_embedded_conjunction([q(X,Y)],[q(Y,f(X))]).

    test(homeomorphic3) :-
        homeomorphic_embedded_conjunction([a,q(X,_Y)],[s,f(a),q(_Y,f(X)),p]).

    test(homeomorphic4) :-
        homeomorphic_embedded_conjunction([q(1,2),q(X,Y)],[q(1,2),q(2,3),q(f(1),f(2)),f(a),q(Y,f(X)),p]).

    test(homeomorphic5) :-
        homeomorphic_embedded_conjunction([],[s,f(a),q(_Y,f(_X)),p]).

    test(homeomorphic6) :-
        homeomorphic_embedded_conjunction([q(X,Y)],[q(X,Y)]).

    test(homeomorphic7) :-
        homeomorphic_embedded_conjunction([q(a,Y)],[q(b,Y),q(c,Y),q(a,Y)]).

    test(homeomorphic8) :-
        homeomorphic_embedded_conjunction([q(a,Y)],[q(b,Y),q(a,Y),q(c,Y)]).

:- end_tests(homeomorphic_embedded_conjunction).

run_homeomorphic_tests :-
    print('run_homeomorphic_tests Start'),nl,
    run_tests(homeomorphic_embedded_conjunction),
    print('run_homeomorphic_tests End'),nl.