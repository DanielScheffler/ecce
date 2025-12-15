
/* ---------------- */
/* Environments.pro */
/* ---------------- */

/* Standard Environment Manipulation tools */

/* ===================================================== */

:- use_module('../multi_meta').

:- multifile multi_meta:pre_condition/1.
:- multifile multi_meta:post_condition/1.
:- multifile multi_meta:ecce_type/2.

/* ===================================================== */



multi_meta:ecce_type(st_lup_binding,term('/',[st_lup_key,st_lup_val])).
multi_meta:ecce_type(st_lup_key,nonvar).
multi_meta:ecce_type(st_lup_val,nonvar).
multi_meta:ecce_type(st_lup_env,list(st_lup_binding)).



multi_meta:pre_condition(store(Env,Key,_Value,_NewEnv)) :-
        term_is_of_type(Env,st_lup_env),
        term_is_of_type(Key,st_lup_key).
multi_meta:post_condition(store(_Env,_Key,_Value,NewEnv)) :-
        term_is_of_type(NewEnv,st_lup_env).

store([],Key,Value,[Key/Value]).
store([Key/Value2|T],Key,Value,[Key/Value|T]).
store([Key2/Value2|T],Key,Value,[Key2/Value2|BT]) :-
   Key \== Key2,
   store(T,Key,Value,BT).


   
multi_meta:pre_condition(lookup(Key,Env,_Value)) :-
        term_is_of_type(Env,st_lup_env),
        term_is_of_type(Key,st_lup_key).
multi_meta:post_condition(lookup(_Key,_Env,_Value)).
        
lookup(Key,[Key/Value|T],Value).
lookup(Key,[Key2/Value2|T],Value) :-
   Key \== Key2,
   lookup(Key,T,Value).
