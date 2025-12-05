:- module(test_runner,[perform_plunit_tests/0]).

/* --------------- */
/* Testing Modules */
/* --------------- */
:- use_module('homeomorphic_tests').
:- use_module('bimtools_tests').
:- use_module('constraints_tests').
:- use_module('calc_chtree_tests').
:- use_module('global_tree_tests').

perform_plunit_tests :-
    run_homeomorphic(Passed1, Failed1),
    run_bimtools(Passed2, Failed2),
    run_constraints(Passed3, Failed3),
    run_calc_chtree(Passed4, Failed4),
    run_global_tree(Passed5, Failed5),
    nl,
    print('-----------------'),nl,
    Passed is Passed1 + Passed2 + Passed3 + Passed4 + Passed5,
    format('~|~t~d~2+ tests passed~n', Passed),
    Failed is Failed1 + Failed2 + Failed3 + Failed4 + Failed5,
    format('~|~t~d~2+ tests failed~n', Failed),
    print('-----------------'),nl,nl,
    print('Type "ecce." and hit return to start the system'),nl,nl.