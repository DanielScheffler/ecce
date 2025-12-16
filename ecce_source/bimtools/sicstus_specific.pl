:- module(sicstus_specific, [consult_without_redefine_warning/1,
						    transform_dcg_term/2,
                            max/3,
                            please/2,
                            rerecord/3,
                            namevars/4,
                            hide/0,
                            is_inf/1,
                            varlist/2,
                            stop/0,
                            time/2,
                            time/1,
                            copy/2,
                            variant_of/2,
                            instance_of/2,
                            strict_instance_of/2,
                            ecce_put/1,
                            ecce_get/1,
                            call_residue/2,
                            filter_residue_vars/2,
                            read_term_with_lines/3,
                            retractall_fact/1,
                            ecce_source_directory/1,
                            ecce_benchmark_directory/1,
                            string_concatenate/3,
                            ensure_consulted/1,
                            ecce_reconsult/1,
                            ecce_compile/1,
                            ecce_use_module/1,
                            ecce_use_module/3,
                            convert_cli_into_atom/2]).


:- use_module(library(system)).
:- use_module(library(lists)).

ecce_source_directory(Res) :- environ('ECCE_SOURCE',R),
  string_concatenate(R,'/',Res).
ecce_benchmark_directory(Res) :- environ('ECCE_BENCHMARKS',R),
  string_concatenate(R,'/',Res).

:- mode string_concatenate(i,i,o).
string_concatenate(X,Y,XY) :-
   name(X,Xs),name(Y,Ys),append(Xs,Ys,XYs),name(XY,XYs).

ensure_consulted(File) :- 
	ecce_source_directory(Dir),
	string_concatenate(Dir,File,CF),!,
	ensure_loaded(CF).

ecce_reconsult(File) :-
	ecce_source_directory(Dir),
	string_concatenate(Dir,File,CF),!,
	consult_without_redefine_warning(CF).

ecce_compile(File) :-
	ecce_source_directory(Dir),
	string_concatenate(Dir,File,CF),!,
	fcompile(CF).

ecce_use_module(File) :- 
	ecce_source_directory(Dir),
	string_concatenate(Dir,File,CF),!,
	use_module(CF).
ecce_use_module(File,A1,A2) :- 
	ecce_source_directory(Dir),
	string_concatenate(Dir,File,CF),!,
	use_module(CF,A1,A2).



:- use_module(library(codesio),[read_from_codes/2]).
	convert_cli_into_atom(CLIGOAL,Atom) :-
		name(CLIGOAL,AsciiL),
		add_dot(AsciiL,AL2),
		read_from_codes(AL2,Atom).

/* sicstus_specific.pro */

consult_without_redefine_warning(File) :-
    prolog_flag(redefine_warnings, Old, off),
    prolog_flag(single_var_warnings, Old2, off),
    (consult(File)
      -> OK=true ; OK=false),
    prolog_flag(redefine_warnings, _, Old),
    prolog_flag(single_var_warnings, _, Old2),
    OK=true.

:- multifile pre_condition/1, post_condition/1, ecce_type/2.
:- dynamic pre_condition/1, post_condition/1, ecce_type/2.

transform_dcg_term(Term,ExpTerm) :-
	expand_term(Term,ExpTerm). 


max(X,Y,Z) :- Z is max(X,Y).


please(_X,_Y). /* to be improved tw,off tw,on */

rerecord(_X,_Y,_Z) :- print('** rerecord **').

namevars(Term,Z,V,_Name) :- numbervars(Term,Z,V).

hide.

:- use_module(library(terms)).
is_inf(X) :- cyclic_term(X).


varlist(T,VList) :- term_variables(T,VList).

stop :- halt.

:- meta_predicate time(:,*).
time(Goal,Time) :- 
	statistics(runtime,[Global1,_]),
	call(Goal),
	statistics(runtime,[Global2,_TimeSinceLastStat]),
	Time is Global2 - Global1.

:- meta_predicate time(:).
time(Goal) :-
	time(Goal,Time),
	print('Time for goal: '),print(Goal),
	print(' is: '),print(Time), print(' ms'),nl.

copy(C,CC) :- copy_term(C,CC).



/* From: instance.pro */


:- use_module(library(terms),[variant/2]).
variant_of(Goal,UIGoal) :-
	copy(Goal,CGoal),
	variant(UIGoal,CGoal).

instance_of(Goal,UIGoal) :- 
	copy(Goal,CGoal),
	subsumes_term(UIGoal,CGoal).

strict_instance_of(Goal1,Goal2) :-
	copy(Goal1,CGoal),
	subsumes_term(Goal2,CGoal),
	\+(subsumes_term(CGoal,Goal2)).
  
ecce_put(X) :- put_code(X).
ecce_get(Ascii) :-
    get_code(Ascii),
	peek_code(Next),
	(Next == 10
	-> get_code(_)
	; true
	).


/* from File: sp4_compatibility_mappings.pl */
/* Created: 08/05/2007 by Michael Leuschel */

:- meta_predicate call_residue(0,*).

call_residue(X,Residue) :- call_residue_vars(X,V),filter_residue_vars(V,Residue).

filter_residue_vars([],[]).
filter_residue_vars([H|T],Res) :-
  frozen(H,FH),
  (FH=true -> Res=RT ; Res = [FH|RT]),
  filter_residue_vars(T,RT).





read_term_with_lines( RTerm , Start , End ) :-
	     read_term(RTerm,[layout(Layout)]), 
	     ((Layout=[Start|_],get_end_of_layout(Layout,End))
	      -> true %, print(layout(Start,End)),nl
	       ; Start = 0,End = -1).
	     %print(read_term_layout(Start,End,Layout)),nl.


get_end_of_layout(X,X) :- atomic(X),!.
get_end_of_layout([X],R) :- !,get_end_of_layout(X,R).
get_end_of_layout([_|T],R) :- get_end_of_layout(T,R).


retractall_fact( X ) :-
	retractall( X ).

:- use_module('../constraints/constraints_clpfd').
