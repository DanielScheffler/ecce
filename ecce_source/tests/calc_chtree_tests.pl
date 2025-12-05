:- module(calc_chtree_tests, [run_calc_chtree/2]).

:- use_module(library(plunit)).
:- use_module('../calc_chtree').

:- begin_tests(divide_constraint_goal).

    test(divide_constraint_goal1, [fail]) :-
        divide_constraint_goal([a,q(_X,_Y)],[],_).

    test(divide_constraint_goal2) :-
        divide_constraint_goal([q(X,Y)],[q(X,Y)],[]).

    test(divide_constraint_goal3) :-
        divide_constraint_goal([a,q(X,Y)],[a,q(X,Y)],[]).

    test(divide_constraint_goal4) :-
        divide_constraint_goal([],[],[]).

:- end_tests(divide_constraint_goal).


:- begin_tests(divide_constraint_residual_goal).

    test(divide_constraint_residual_goal1, [fail]) :-
        divide_constraint_residual_goal([a,q(_X,_Y)],[],_).

    test(divide_constraint_residual_goal2) :-
        divide_constraint_residual_goal([q(X,Y)],[q(X,Y)],[]).

    test(divide_constraint_residual_goal3) :-
        divide_constraint_residual_goal([a,q(X,Y)],[a,q(X,Y)],[]).

    test(divide_constraint_residual_goal4) :-
        divide_constraint_residual_goal([],[],[]).

:- end_tests(divide_constraint_residual_goal).


run_calc_chtree(Passed, Failed) :-
    run_tests([divide_constraint_goal, divide_constraint_residual_goal], [passed(Passed), failed(Failed)]).