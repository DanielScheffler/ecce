/* ================================= */
/*   E C C E    for Sicstus Prolog   */
/* ================================= */


/* --------------------------------------------- */
/* (C) COPYRIGHT MICHAEL LEUSCHEL 1995,96,97,98  */
/* --------------------------------------------- */


/* load this file to start up the ECCE system in Sicstus Prolog */

:- op( 1000 , fx , data ).

/* Needs to be added to Files, not in Module user, which include not Sicstus Code */
:- ensure_loaded('sicstus_expansion').

:- use_module('bimtools/sicstus_specific').


%ecce_recompile :- ecce_reconsult('ecce_compile').

:- use_module('ecce_main.pl').

:- nl,nl,print('Type "run_tests." and hit return to run Plunit tests'),nl.
:- print('Type "ecce." and hit return to start the system'),nl,nl.