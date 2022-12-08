n;;; -*-  Mode: Lisp; Package: Maxima; Syntax: Common-Lisp; Base: 8 -*- ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     The data in this file contains enhancments.                    ;;;;;
;;;                                                                    ;;;;;
;;;  Copyright (c) 1984,1987 by William Schelter,University of Texas   ;;;;;
;;;     All rights reserved                                            ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :maxima)

(defvar *macro-file* nil)

#+gcl
(progn 
  (system::clines "object MAKE_UNSPECIAL(object x) {if (type_of(x)==t_symbol) x->s.s_stype=0;return Cnil;}")
  (system::defentry make-unspecial (system::object) (system::object "MAKE_UNSPECIAL")))

#+(or scl cmu)
(defun make-unspecial (symbol)
  (ext:clear-info variable c::kind symbol)
  symbol)


(defmacro declare-top (&rest decl-specs)
  `(eval-when
    ,(cond (*macro-file*  #+gcl '(compile eval load)
			  #-gcl '(:compile-toplevel :load-toplevel :execute) )
	   (t #+gcl '(eval compile) #-gcl '(:compile-toplevel :execute)))
    ,@(loop for v in decl-specs
	     unless (member (car v) '(special unspecial)) nconc nil
	     else
	     when (eql (car v) 'unspecial)
	     collect `(progn
		       ,@(loop for w in (cdr v)
				collect #-(or gcl scl cmu ecl)
                                       `(remprop ',w
						 #-excl 'special
						 #+excl 'excl::.globally-special.)
				#+(or gcl scl cmu ecl)
			        `(make-unspecial ',w)))
	     else collect `(proclaim ',v))))

;;; This list should contain all specials required by runtime or more than one maxima file,
;;; except for some specials declared in the macro files, eg displm

(declaim (special
	  $% $%% $%emode $%e_to_numlog $%iargs $%piargs
	  $%rnum $absboxchar $activecontexts $algexact
	  $aliases $arrays $askexp $berlefact
	  $beta_args_sum_to_integer $bftorat $bftrunc $boxchar
	  $breakup $compgrind $context
	  $contexts $current_let_rule_package $debugmode
	  $default_let_rule_package
	  $dispflag
	  $display_format_internal $domain $domxexpt $domxmxops
	  $domxnctimes $domxplus $domxtimes
	  $doscmxplus $dot0nscsimp $dot0simp $dot1simp
	  $dotconstrules $dotident
	  $erfflag $errexp $error_size $error_syms $expon
	  $exponentialize $expop $exptdispflag $exptisolate
	  $facexpand $file_search
	  $float2bf $floatformat $floatfrac $floatint
	  $floatoptions $floatprec $floatwidth $fortfloat $fortindent
	  $fortspaces $fpprec $fpprintprec $functions $gammalim $gcd
	  $halfangles $homog_hack
	  $inchar
	  $isolate_wrt_times $labels $leftjust $letrat $letvarsimp
	  $let_rule_packages $liflag $linechar $linenum
	  $linsolvewarn $linsolve_params $listarith
	  $lmxchar $logarc $logconcoeffp $logexpand $lognegint
	  $logsimp $m1pbranch $macroexpansion $macros $maperror $mapprint
	  $matrix_element_transpose
	  $maxapplydepth $maxapplyheight $maxnegex $maxposex
	  $maxtayorder $mode_checkp $mode_check_errorp $mode_check_warnp
	  $multiplicities $mx0simp $myoptions $nalgfac $negdistrib
	  $negsumdispflag $nolabels $noundisp $numer
	  $numer_pbranch $optimprefix $optionset $outchar
	  $parsewindow $pointbound
	  $poislim $programmode $props
	  $radexpand $ratdenomdivide $ratepsilon $ratexpand
          $ratmx $ratprint $ratsimpexpons $ratvars $ratvarswitch
	  $realonly $refcheck $resultant $rmxchar
	  $rules
	  $setval $signbfloat $simp
	  $solvedecomposes $solveexplicit $solvefactors $solvenullwarn
	  $solveradcan $solvetrigwarn
	  $stardisp $sublis_apply_lambda
	  $subnumsimp $sumexpand
	  $taylor_logexpand
	  $taylor_truncate_polynomials $timer $timer_devalue
	  $trace $trace_break_arg $trace_max_indent
	  $trace_safety $transrun
	  $trigexpand $trigexpandplus $trigexpandtimes $triginverses
	  $trigsign $tr_array_as_ref $tr_bound_function_applyp
	  $tr_file_tty_messagesp $tr_float_can_branch_complex
	  $tr_function_call_default $tr_numer
	  $tr_optimize_max_loop
	  $tr_state_vars
	  $tr_true_name_of_file_being_translated $tr_warn_bad_function_calls
	  $tr_warn_fexpr $tr_warn_meval $tr_warn_mode $tr_warn_undeclared
	  $tr_warn_undefined_variable $ttyoff
	  $values $vect_cross
	  %e-val %pi-val %pi//2 %pi//4 %pi2 *$any-modes*
	  *alpha *const* *fnewvarsw *gcdl* *in *in-compile*
	  *in-translate-file* *inv* *irreds *min* *mx*
	  *n *opers-list *out *ratweights *tr-warn-break* *transl-backtrace*
	  *transl-debug* *warned-fexprs*
	  *warned-mode-vars* *warned-un-declared-vars* *zexptsimp? |-1//2|
	  -sqrt3//2 |1//2| adn* aexprp algnotexact
	  alpha *alphabet* assigns
	  *mdebug*
	  defined_variables defintdebug derivflag derivlist
	  derivsimp displayp dn* dosimp dsksetp
	  errorsw expandflag expandp
	  exptrlsw
	  fr-factor gauss
	  generate-atan2 genpairs genvar
	  implicit-real inratsimp inside-mprog
	  limit-answers
	  *linelabel* local maplp mdop
	  meta-prop-l meta-prop-p mfexprp minpoly* mm* modulus
	  mplc* mprogp mproplist mspeclist
	  need-prog? negprods negsums nn*
	  *nounsflag* opers opers-list outargs1 outargs2
	  preserve-direction prods radcanp
	  realonlyratnum *refchkl* return-mode returns rulefcnl
	  rulesw sign-imag-errp simplimplus-problems
	  *small-primes* sqrt3//2
	  sums tellratlist timesinp tr-abort tr-progret tr-unique
	  transl-file translate-time-evalables
	  tstack varlist wflag
	  *trunclist
	  $maxtaydiff $verbose $psexpand ps-bmt-disrep
	  $define_variable $infolists
	  $factor_max_degree_print_warning))

(declaim (declaration unspecial))
