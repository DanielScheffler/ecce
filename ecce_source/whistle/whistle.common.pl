:- module( 'whistle.common' , [not_more_general_conjunction1/2, 
							goal_naive_homeo/2, 
							naive_homeo/2, 
							l_naive_homeo/2] ).

:- use_module( '../bimtools.pl' ).
:- use_module( '../homeomorphic.pl' ).

not_more_general_conjunction1(ParGoal,Goal) :-
  not_more_general_conjunction(ParGoal,Goal), !.

goal_naive_homeo([],[]) :- !.
goal_naive_homeo([X|XA],[Y|YA]) :- !,
	naive_homeo(X,Y),
	goal_naive_homeo(XA,YA).
goal_naive_homeo(X,Y) :- naive_homeo(X,Y).

naive_homeo(X,Y) :-
	X=..[Func|XA],
	Y=..[Func|YA],
	l_naive_homeo(XA,YA).

l_naive_homeo([],[]).
l_naive_homeo([X|XA],[Y|YA]) :-
	(var(Y); homeomorphic_embedded(X,Y)),!
	,l_naive_homeo(XA,YA).
