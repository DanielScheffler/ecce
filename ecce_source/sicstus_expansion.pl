/* Some term_expansions needed to make mecce-ciao run in sicstus again */
:-if(current_prolog_flag(dialect,sicstus)).


:- multifile term_expansion/6.
term_expansion( :-(use_module(library(dec10_io))), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_module(library(dynamic))), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_module(library(aggregates))), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_module(library(sort))), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_module(library(prolog_sys))), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_module(engine(internals))), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_module(engine(internals),_)), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(use_package(_)), L1,T, [], L1, [remove_ciao|T] ).

term_expansion( :-(meta_predicate(_)), L1,T, [], L1, [remove_ciao|T] ).
 
term_expansion( :-(set_prolog_flag(multi_arity_warnings,X)) , L1,T, 
	        :-(set_prolog_flag(discontiguous_warnings,X)), L1, [remove_ciao|T] ).

term_expansion( :-(data(X))    , L1,T, 
	        :-(dynamic(X)), L1, [remove_ciao|T] ).

term_expansion( :-(include('bimtools/ciao_specific.pl')), L1,T, 
	        :-(use_module('bimtools/sicstus_specific.pl')), L1, [remove_ciao|T] ).

term_expansion( :-(include('ciao_specific.pl')), L1,T, 
	        :-(use_module('sicstus_specific.pl')), L1, [remove_ciao|T] ).

term_expansion( :-(use_module('bimtools/makeflat')) , L1,T, :-(use_module(makeflat)), L1, [remove_ciao|T] ).

term_expansion( :-(use_module('bimtools/makeiff')) , L1,T, :-(use_module(makeiff)), L1, [remove_ciao|T] ).

goal_expansion( retract_fact( X ) , L1 , _ , retract( X ), L1 ).

goal_expansion( asserta_fact( X ), L1 , _ ,  assert( X ), L1 ).

goal_expansion( assertz_fact( X ), L1 , _ ,  assert( X ), L1 ).

:-endif.	