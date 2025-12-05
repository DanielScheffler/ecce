:- module(stdlists, [exact_member/2, member_nr/3, split_list/5]).
/* --------------------------------------------- */
/* (C) COPYRIGHT MICHAEL LEUSCHEL 1995,1996,1997 */
/* --------------------------------------------- */


/* ------------ */
/* StdLists.pro */
/* ------------ */

/* ------ */
/* append */
/*------- */
pre_condition(append(X,_Y,_Z)) :-
	term_is_of_type(X,list(any),no),!.
pre_condition(append(_X,_Y,Z)) :-
	term_is_of_type(Z,list(any)).

post_condition(append(_X,_Y,_Z)).



/* ---------- */
/*   member   */
/* ---------- */
pre_condition(member(_X,List)) :-
	term_is_of_type(List,list(any)).

post_condition(member(_X,_List)).



/* ---------------- */
/*   exact_member   */
/* ---------------- */
pre_condition(exact_member(_X,List)) :-
	term_is_of_type(List,list(any)).

post_condition(exact_member(_X,_List)).
 
exact_member(X,[Y|T]) :- 
 ((X==Y) -> true ; exact_member(X,T)).



/* ------------- */
/*   member_nr   */
/* ------------- */
pre_condition(member_nr(_X,List,_Nr)) :-
	term_is_of_type(List,list(any)).

post_condition(member_nr(_X,_List,Nr)) :-
	term_is_of_type(Nr,integer).

member_nr(X,[X|_T],1).
member_nr(X,[_Y|T],Nr) :-
	member_nr(X,T,TNr),
	Nr is TNr + 1.



/* ---------------- */
/* length(List,Len) */
/* ---------------- */
pre_condition(length(List,_Len)) :-
	term_is_of_type(List,list(any)).

post_condition(length(_List,Len)) :-
	term_is_of_type(Len,integer).



/* --------------------------------------- */
/* split_list(List,Pos,Left,ElAtPos,Right) */
/* --------------------------------------- */
pre_condition(split_list(List,Pos,_Left,_ElAtPos,_Right)) :-
	term_is_of_type(List,list(any)),
	term_is_of_type(Pos,integer).

post_condition(split_list(_List,_Pos,Left,_ElAtPos,Right)) :-
	term_is_of_type(Left,list(any)),
	term_is_of_type(Right,list(any)).

split_list([H|T],1,[],H,T) :- !.
split_list([H|T],Nr,[H|Left],ElAtNr,Right) :-
	Nrm1 is Nr - 1,
	split_list(T,Nrm1,Left,ElAtNr,Right).



/* ------------------------ */
/* reverse(List,Acc,Result) */
/* ------------------------ */
pre_condition(reverse(List,_Result)) :-
	term_is_of_type(List,list(any)).
post_condition(reverse(_List,Result)) :-
	term_is_of_type(Result,list(any)).



/* ------------------------ */
/* reverse(List,Acc,Result) */
/* ------------------------ */
pre_condition(reverse(List,Acc,_Result)) :-
	term_is_of_type(List,list(any)),
	term_is_of_type(Acc,list(any)).
post_condition(reverse(_List,_Acc,Result)) :-
	term_is_of_type(Result,list(any)).