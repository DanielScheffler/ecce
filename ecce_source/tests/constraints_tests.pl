:- module(constraints_test, [run_constraints/2]).

:- use_module(library(plunit)).
:- use_module('../constraints').
:- use_module('../bimtools', [pp_mnf/1, pp_cll/1]).


:- begin_tests(constraint_instance_of).

    test(constraint_instance_of1) :-
        (pp_mnf(constraint_instance_of([p(a)],[],[p(a)],[]))).

    test(constraint_instance_of2) :-
        (pp_mnf(constraint_instance_of([p(a)],[],[p(_X)],[]))).

    test(constraint_instance_of3) :-
        (pp_mnf(constraint_instance_of([p(a)],[],[p(X)],[ecce_type(cst(a),X)]))).

    test(constraint_instance_of4, [nondet]) :-
        (pp_mnf(constraint_instance_of([p([a])],[],[p(X)],[ecce_type(list(cst(a)),X)]))).

    test(constraint_instance_of5, [fail]) :-
        (pp_cll(constraint_instance_of([p(_X)],[],[p(a)],[]))).

    test(constraint_instance_of6, [fail]) :-
        (pp_cll(constraint_instance_of([p(a)],[],[p(X)],[ecce_type(cst(b),X)]))).

    test(constraint_instance_of7, [fail]) :-
        (pp_cll(constraint_instance_of([p(a)],[],[p(X)],[ecce_type(list(cst(a)),X)]))).

    test(constraint_instance_of8, [fail]) :-
        (pp_cll(constraint_instance_of([p([a])],[],[p(X)],[ecce_type(list(cst(b)),X)]))).

:- end_tests(constraint_instance_of).


:- begin_tests(simplify_constraint).

    test(simplify_constraint1) :-
        (pp_mnf(simplify_constraint([ecce_type(list(any),X)],L)),L == [ecce_type(list(any),X)]).

    test(simplify_constraint2, [nondet]) :-
        (pp_mnf(simplify_constraint([ecce_type(rec(a,f),f(f(a)))],L)),L== []).

    test(simplify_constraint3, [nondet]) :-
        (pp_mnf(simplify_constraint([ecce_type(rec2(a,f),f(a,f(X,f(a,a))))],L)),L== [ecce_type(rec2(a,f),X)]).

    test(simplify_constraint4) :-
        (pp_mnf(simplify_constraint([ecce_type(list(any),[_H|T])],L)),L == [ecce_type(list(any),T)]).

    test(simplify_constraint5) :-
        (pp_mnf(simplify_constraint([ecce_type(cst(2),2)],L)),L == []).

    test(simplify_constraint6) :-
        (pp_mnf(simplify_constraint([ecce_type(list(cst(2)),[2,2,2|T]), ecce_type(list(any),X)],L)),
        L == [ecce_type(list(cst(2)),T),ecce_type(list(any),X)]).

    test(simplify_constraint7, [fail]) :-
        (pp_cll(simplify_constraint([ecce_type(list(cst(2)),[2,2,4|_T]), ecce_type(list(any),_X)],_L))).

:- end_tests(simplify_constraint).


:- begin_tests(project_constraint).

    test(project_constraint1) :-
        (pp_mnf(project_constraint([ecce_type(list(any),X)],X,L)),L == [ecce_type(list(any),X)]).

    test(project_constraint2) :-
        (pp_mnf(project_constraint([ecce_type(list(any),_Z)],f(X,X),L)),L == []).

    test(project_constraint3) :-
        (pp_mnf(project_constraint([],f(_X),L)),L == []).

    test(project_constraint4) :-
        (pp_mnf(project_constraint(
                  [ecce_type(list(any),_Z),ecce_type(list(any),X),ecce_type(cst(2),_V),
                   ecce_type(list(cst(1)),[X])],f(X,_Y),L)),
            L == [ecce_type(list(any),X),ecce_type(list(cst(1)),[X])]).

:- end_tests(project_constraint).


:- begin_tests(project_simplified_constraint).

    test(project_simplified_constraint1) :-
        (pp_mnf(project_simplified_constraint([ecce_type(list(any),X)],X,L,R)),L == [ecce_type(list(any),X)], R==[]).

    test(project_simplified_constraint2) :-
        (pp_mnf(project_simplified_constraint([ecce_type(list(any),_Z)],f(X,X),L,R)),
        L == [], R==[ecce_type(list(any),_Z)]).

    test(project_simplified_constraint3) :-
        (pp_mnf(project_simplified_constraint([],f(_X),L,R)),L == [], R==[]).

    test(project_simplified_constraint4) :-
        (pp_mnf(project_simplified_constraint(
                  [ecce_type(list(any),_Z),ecce_type(list(any),X),ecce_type(cst(2),_V),
                   ecce_type(list(cst(1)),X)],f(X,_Y),L,R)),
            L == [ecce_type(list(any),X),ecce_type(list(cst(1)),X)],
            R == [ecce_type(list(any),_Z), ecce_type(cst(2),_V)]).

:- end_tests(project_simplified_constraint).


run_constraints(Passed, Failed) :-
    run_tests([constraint_instance_of, simplify_constraint, project_constraint, project_simplified_constraint], [passed(Passed), failed(Failed)]).