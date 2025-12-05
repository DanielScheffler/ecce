:- module(bimtools_tests, [run_bimtools/2]).

:- use_module(library(plunit)).
:- use_module('../bimtools').


:- begin_tests(variant_of).

    test(variant_of1, [fail]) :-
         variant_of(p(_X),p(a)).

    test(variant_of2, [fail]) :-
        variant_of(p(a),p(_X)).

    test(variant_of3, [fail]) :-
        variant_of(q(X,_Y),q(X,X)).

    test(variant_of4) :-
        variant_of(q(X,Y),q(Y,X)).

    test(variant_of5) :-
        variant_of(q(X,Y),q(X,Y)).

:- end_tests(variant_of).


:- begin_tests(instance_of).

    test(instance_of1, [fail]) :-
        instance_of(q(X),q(f(X))).

    test(instance_of2, [fail]) :-
        instance_of(q(X,_Y),q(X,X)).

    test(instance_of3, [fail]) :-
        instance_of(q(_Y,a),q(X,X)).

    test(instance_of4, [fail]) :-
        instance_of(q(X,X),q(_Y,a)).

    test(instance_of5, [fail]) :-
        instance_of(r,q(X,X)).

    test(instance_of6, [fail]) :-
        instance_of(p([s],_X),s).

    test(instance_of7) :-
        instance_of(q(X),q(X)).

    test(instance_of8) :-
        instance_of(q(f(X)),q(X)).

    test(instance_of9) :-
        instance_of(q(X,Y),q(Y,X)).

    test(instance_of10) :-
        instance_of(q(X,Y),q(Y,X)).

:- end_tests(instance_of).


:- begin_tests(strict_instance_of).

    test(strict_instance_of1, [fail]) :-
        strict_instance_of(q(_Z,_V),q(_X,_Y)).

    test(strict_instance_of2, [fail]) :-
        strict_instance_of(q(Z,V),q(Z,V)).

    test(strict_instance_of3, [fail]) :-
        strict_instance_of(q(X,X),q(_Y,a)).

    test(strict_instance_of4, [fail]) :-
        strict_instance_of(q(_T,a),q(X,X)).

    test(strict_instance_of5, [fail]) :-
        strict_instance_of(r,q(X,X)).

    test(strict_instance_of6, [fail]) :-
        strict_instance_of(p([s],_X),s).

    test(strict_instance_of7) :-
        strict_instance_of(q(f(X)),q(X)).

    test(strict_instance_of8) :-
        strict_instance_of(q(X,X),q(X,_Y)).

:- end_tests(strict_instance_of).


:- begin_tests(stdlists_exact_member).

    test(stdlists_exact_member1) :-
        exact_member(1,[1,2,3]).

    test(stdlists_exact_member2) :-
        exact_member(X,[1,X,3]).

    test(stdlists_exact_member3) :-
        exact_member(X,[1,2,X]).

    test(stdlists_exact_member4, [fail]) :-
        exact_member(_X,[1,_Y,3,3]).

:- end_tests(stdlists_exact_member).


:- begin_tests(stdlists_member_nr).

    test(stdlists_member_nr1, [nondet]) :-
        member_nr(2,[1,2,3],2).

    test(stdlists_member_nr2, [nondet]) :-
        member_nr(3,[1,2,3],3).

    test(stdlists_member_nr3, [fail]) :-
        member_nr(_X,[1,2,3],4).

    test(stdlists_member_nr4, [fail]) :-
        member_nr(4,[1,2,3],_X).

    test(stdlists_member_nr5, [fail]) :-
        member_nr(0,[1,2,3],_X).

:- end_tests(stdlists_member_nr).


:- begin_tests(stdlists_split_list).

    test(stdlists_split_list1) :-
        split_list([a,b,c],2,[a],b,[c]).

    test(stdlists_split_list2) :-
        split_list([a,b,c],1,[],a,[b,c]).

    test(stdlists_split_list3) :-
        split_list([a,b,c],3,[a,b],c,[]).

    test(stdlists_split_list4, [fail]) :-
        split_list([a,b,c],0,_,_,_).

    test(stdlists_split_list5, [fail]) :-
        split_list([a,b,c],4,_,_,_).

:- end_tests(stdlists_split_list).


run_bimtools(Passed, Failed) :-
    run_tests([variant_of, instance_of, strict_instance_of, stdlists_exact_member, stdlists_member_nr, stdlists_split_list], [passed(Passed), failed(Failed)]).