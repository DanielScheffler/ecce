:- module(global_tree_tests, [run_global_tree/2]).

:- use_module(library(plunit)).
:- use_module('../global_tree').
:- use_module('../bimtools', [pp_mnf/1]).


:- begin_tests(global_tree).

    test(global_tree1, [setup(init_gt)]) :-
        (pp_mnf(add_gt_croot([p(Z)],[ecce_type(list(any),Z)],NodeID)),
        pp_mnf(mark_gt_node_as_ped(NodeID,pe(unimposed),stop)),
        pp_mnf(add_gt_cleaf(NodeID,[q(Z),r(Z)],[ecce_type(list(any),Z)],chpos(1,[1,2]),_LeafID))).

    test(global_tree2) :-
        (get_gt_cgoal_to_pe(_GID,G,C), C=[ecce_type(list(any),Z)],G = [q(Z),r(Z)]).

    test(global_tree3, [setup(init_gt)]) :-
        (pp_mnf(add_gt_root([p(Z)],NodeID)),
        pp_mnf(mark_gt_node_as_ped(NodeID,pe(unimposed),stop)),
        pp_mnf(add_gt_leaf(NodeID,[q(Z),r(Z)],chpos(1,[1,2]),_LeafID))).

    test(global_tree4) :-
        (get_gt_cgoal_to_pe(_GID,G,C), C=[],G = [q(Z),r(Z)]).

:- end_tests(global_tree).

run_global_tree(Passed, Failed) :-
    run_tests([global_tree], [passed(Passed), failed(Failed)]).