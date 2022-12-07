;;;; -*-  Mode: Lisp; Package: Maxima; Syntax: Common-Lisp; Base: 10 -*- ;;;;

;;;; This file contains global vars (defvars/defmvars) that are used in
;;;; multiple files.  We gather them all here so that they are
;;;; consistently defined across the build and to make the dependencies
;;;; easier to track.

(in-package "MAXIMA")

(defvar *variable-initial-values* (make-hash-table)
  "Hash table containing all Maxima defmvar variables and their
  initial values")

(defmacro defmvar (var &optional (val nil valp) (doc nil docp) &rest options)
  "Define a Maxima variable VAR that is user-visible.  It is
  initialized to the value VAL.  An associated documentation string
  can be supplied in DOC.  OPTIONS contains a list of options that can
  be applied to the variable.

  The valid options are:

    NO-RESET        - If given, the variable will not be reset.
    FIXNUM, BOOLEAN - The variable is declared to have this type.
    :PROPERTIES     - A list of properties to be applied for this variable.

  The list of properties has the form ((ind1 val1) (ind2 val2) ...)
  where IND1 is the name of the property and VAL1 is the value
  associated with the property.

  Other options that are recognized but ignored: IN-CORE, SEE-ALSO,
  MODIFIED-COMMANDS, SETTING-PREDICATE, SETTING-LIST.  For any other
  options, a warning is produced.
"
  (let ((maybe-reset
          ;; Default is to reset the variable to it's initial value.
          `((unless (gethash ',var *variable-initial-values*)
              (setf (gethash ',var *variable-initial-values*)
                    ,val))))
        maybe-declare-type
        maybe-set-props)

    (do ((opts options (rest opts)))
        ((null opts))
      #+nil
      (format t "opts = ~S~%" opts)
      (case (car opts)
        (no-reset
         ;; Don't reset the value
         (setf maybe-reset nil))
        ((fixnum boolean string flonum)
	 ;; Don't declare the types yet.  There are testsuite failures
	 ;; with sbcl that some things declared fixnum aren't assigned
	 ;; fixnum values.  Some are clearly bugs in the code where we
	 ;; do things like
	 ;;
	 ;;  (let ($expop ...)
	 ;;    (setq $expop 0))
	 ;;
	 ;; Some known such variables: $expop, $fpprintprec (in ev
	 ;; statements), $factors_only, $expon,
	 ;;
	 ;; We should also note that when this is fixed, we should
	 ;; also add an 'assign property to verify that only fixnums,
	 ;; etc., are allowed.
         #+nil
	 (setf maybe-declare-type
               `((declaim (type ,(car opts) ,var)))))
        (in-core
         ;; Ignore this
         )
       (:properties
         (setf maybe-set-props
               (mapcar #'(lambda (o)
                           (destructuring-bind (ind val)
                               o
                             `(putprop ',var ',val ',ind)))
                       (second opts)))
         (setf opts (rest opts)))
        ((see-also modified-commands setting-predicate setting-list)
         ;; Not yet supported, but we need to skip over the following
         ;; item too which is the parameter for this option.
         (setf opts (rest opts)))
        (t
         (warn "Ignoring unknown defmvar option for ~S: ~S"
               var (car opts)))))
    `(progn
       ,@maybe-reset
       ,@maybe-declare-type
       (defvar ,var ,val ,doc)
       ,@maybe-set-props)))

(defun putprop (sym val  indic)
  (if (consp sym)
      (setf (getf (cdr sym) indic) val)
      (setf (get sym indic) val)))

;;; Declare user-visible special variables and other global special variables.

(defvar infinities '($inf $minf $infinity)
  "The types of infinities recognized by Maxima.
   INFINITY is complex infinity")

(defvar real-infinities '($inf $minf)
  "The real infinities, `inf' is positive infinity, `minf' negative infinity")

(defvar infinitesimals '($zeroa $zerob)
  "The infinitesimals recognized by Maxima. ZEROA zero from above,
   ZEROB zero from below")

;;------------------------------------------------------------------------
;; From clmacs.lisp
;;
;; Define useful floating-point constants
#+clisp
(progn
  ;; This used to be enabled, but
  ;; http://clisp.cons.org/impnotes/num-dict.html seems to indicate
  ;; that the result of float, coerce, sqrt, etc., on a rational will
  ;; return a float of the specified type.  But ANSI CL says we must
  ;; return a single-float.  I (rtoy) am commenting this out for now.

  ;; (setq custom:*default-float-format* 'double-float)

  ;; We currently don't want any warnings about floating-point contagion.
  (setq custom::*warn-on-floating-point-contagion* nil)

  ;; We definitely want ANSI-style floating-point contagion.
  (setq custom:*floating-point-contagion-ansi* t)

  ;; Set custom:*floating-point-rational-contagion-ansi* so that
  ;; contagion is done as per the ANSI CL standard. Has an effect only
  ;; in those few cases when the mathematical result is exact although
  ;; one of the arguments is a floating-point number, such as (* 0
  ;; 1.618), (/ 0 1.618), (atan 0 1.0), (expt 2.0 0)
  (setq custom:*floating-point-rational-contagion-ansi* t)

  ;; When building maxima using with 'flonum being a 'long-float it may be
  ;; useful to adjust the number of bits of precision that CLISP uses for
  ;; long-floats.
  #+nil
  (setf (ext:long-float-digits) 128)

  ;; We want underflows not to signal errors.
  (ext:without-package-lock ()
    (setq sys::*inhibit-floating-point-underflow* t))
  )

#+abcl
(progn
  ;; We want underflows not to signal errors
  (when (fboundp (find-symbol "FLOAT-UNDERFLOW-MODE" "SYS"))
    (funcall (find-symbol "FLOAT-UNDERFLOW-MODE" "SYS") nil))
  )

;; Make the maximum exponent larger for CMUCL.  Without this, cmucl
;; will generate a continuable error when raising an integer to a
;; power greater than this.
#+cmu
(setf ext::*intexp-maximum-exponent* 100000)
;;;; Setup the mapping from the Maxima 'flonum float type to a CL float type.
;;;;
;;;; Add :flonum-long to *features* if you want flonum to be a
;;;; long-float.  Or add :flonum-double-double if you want flonum to
;;;; be a double-double (currently only for CMUCL).  Otherwise, you
;;;; get double-float as the flonum type.
;;;;
;;;; Default double-float flonum.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (setq *read-default-float-format* 'double-float))

#-(or flonum-long flonum-double-double)
(progn
;; Tell Lisp the float type for a 'flonum.
#-(or clisp abcl)
(deftype flonum (&optional low high)
  (cond (high
	 `(double-float ,low ,high))
	(low
	 `(double-float ,low))
	(t
	 'double-float)))

;; Some versions of clisp and ABCL appear to be buggy: (coerce 1 'flonum)
;; signals an error.  So does (coerce 1 '(double-float 0d0)).  But
;; (coerce 1 'double-float) returns 1d0 as expected.  So for now, make
;; flonum be exactly the same as double-float, without bounds.
#+(or clisp abcl)
(deftype flonum (&optional low high)
  (declare (ignorable low high))
  'double-float)

(defconstant most-positive-flonum most-positive-double-float)
(defconstant most-negative-flonum most-negative-double-float)
(defconstant least-positive-flonum least-positive-double-float)
(defconstant least-negative-flonum least-negative-double-float)
(defconstant flonum-epsilon double-float-epsilon)
(defconstant least-positive-normalized-flonum least-positive-normalized-double-float)
(defconstant least-negative-normalized-flonum least-negative-normalized-double-float)

(defconstant flonum-exponent-marker #\D)
)

#+flonum-long
(progn
;;;; The Maxima 'flonum can be a CL 'long-float on the Scieneer CL or CLISP,
;;;; but should be the same as 'double-float on other CL implementations.

  (eval-when (:compile-toplevel :load-toplevel :execute)
    (setq *read-default-float-format* 'long-float))

;; Tell Lisp the float type for a 'flonum.
(deftype flonum (&optional low high)
  (cond (high
	 `(long-float ,low ,high))
	(low
	 `(long-float ,low))
	(t
	 'long-float)))

(defconstant most-positive-flonum most-positive-long-float)
(defconstant most-negative-flonum most-negative-long-float)
(defconstant least-positive-flonum least-positive-long-float)
(defconstant least-negative-flonum least-negative-long-float)
(defconstant flonum-epsilon long-float-epsilon)
(defconstant least-positive-normalized-flonum least-positive-normalized-long-float)

(defconstant flonum-exponent-marker #\L)

)

#+flonum-double-double
(progn

;;;; The Maxima 'flonum can be a 'kernel:double-double-float on the CMU CL.

  (eval-when (:compile-toplevel :load-toplevel :execute)
    (setq *read-default-float-format* 'kernel:double-double-float))

;; Tell Lisp the float type for a 'flonum.
(deftype flonum (&optional low high)
  (cond (high
	 `(kernel:double-double-float ,low ,high))
	(low
	 `(kernel:double-double-float ,low))
	(t
	 'kernel:double-double-float)))

;; While double-double can represent number as up to
;; most-positive-double-float, it can't really do operations on them
;; due to the way multiplication and division are implemented.  (I
;; don't think there's any workaround for that.)
;;
;; So, the largest number that can be used is the float just less than
;; 2^1024/(1+2^27).  This is the number given here.
(defconstant most-positive-double-double-hi
  (scale-float (cl:float (1- 9007199187632128) 1d0) 944))

(defconstant most-positive-flonum (cl:float most-positive-double-double-hi 1w0))
(defconstant most-negative-flonum (cl:float (- most-positive-double-double-hi 1w0)))
(defconstant least-positive-flonum (cl:float least-positive-double-float 1w0))
(defconstant least-negative-flonum (cl:float least-negative-double-float 1w0))
;; This is an approximation to a double-double epsilon.  Due to the
;; way double-doubles are represented, epsilon is actually zero
;; because 1+x = 1 only when x is zero.  But double-doubles only have
;; 106 bits of precision, so we use that as epsilon.
(defconstant flonum-epsilon (scale-float 1w0 -106))
(defconstant least-positive-normalized-flonum (cl:float least-positive-normalized-double-float 1w0))

(defconstant flonum-exponent-marker #\W)

)



;;------------------------------------------------------------------------
;; From algsys.lisp
(defmvar $%rnum_list '((mlist))
  "Upon exit from ALGSYS this is bound to a list of the %RNUMS
	 which where introduced into the expression. Useful for mapping
	 over and using as an argument to SUBST.")

;;------------------------------------------------------------------------
;; From asum.lisp
(defmvar $zeta%pi t)

;; factorial stuff

(defmvar $factlim 100000) ; set to a big integer which will work (not -1)
(defvar makef nil)

(defmvar $cauchysum nil
  "When multiplying together sums with INF as their upper limit, 
causes the Cauchy product to be used rather than the usual product.
In the Cauchy product the index of the inner summation is a function of 
the index of the outer one rather than varying independently."
  modified-commands '$sum)

;; sum begins
(defmvar $gensumnum 0
  "The numeric suffix used to generate the next variable of
summation.  If it is set to FALSE then the index will consist only of
GENINDEX with no numeric suffix."
  modified-commands '$sum
  setting-predicate #'(lambda (x) (or (null x) (integerp x))))

(defmvar $genindex '$i
  "The alphabetic prefix used to generate the next variable of
summation when necessary."
  modified-commands '$sum
  setting-predicate #'symbolp)

(defmvar $zerobern t)
(defmvar $simpsum nil)
(defmvar $simpproduct nil)

(defvar *infsumsimp t)

(defmvar $cflength 1)
(defmvar $taylordepth 3)
(defmvar $verbose nil)

(defvar ps-bmt-disrep t)
(defvar silent-taylor-flag nil
  ;; From comment in hayat.lisp
  "If true indicates that errors will be returned via a throw to
  TAY-ERR")

;;------------------------------------------------------------------------
;; From comm2.lisp
(defmvar $rootsconmode t)

;;------------------------------------------------------------------------
;; From comm.lisp
(defmvar $exptsubst nil)
(defmvar $partswitch nil)
(defmvar $inflag nil)
(defmvar $derivsubst nil)
(defmvar $opsubst t)

(defvar *islinp* nil
  "When T, sdiff is called from the function islinear")
(defvar *atp* nil
  "When T, prevents substitution from applying to vars ; bound by %sum,
  %product, %integrate, %limit")

;; Store built-in operators, which get additional properties.
;; These operators aren't killed by the function kill-operator.
(defvar *mopl* nil)

(defvar $gradefs '((mlist simp)))
(defvar $dependencies '((mlist simp)))

(defvar atvars '($@1 $@2 $@3 $@4))
(defvar in-p nil)
(defvar substp nil)

(defvar dummy-variable-operators '(%product %sum %laplace %integrate %limit %at))

;;------------------------------------------------------------------------
;; From compar.lisp
(defmvar $prederror nil)
(defmvar limitp)

;;------------------------------------------------------------------------
;; From cpoly.lisp
(defmvar $polyfactor nil
  "When T factor the polynomial over the real or complex numbers.")

;;------------------------------------------------------------------------
;; From csimp2.lisp
(defmvar $gamma_expand nil
  "Expand gamma(z+n) for n an integer when T.") 

;;------------------------------------------------------------------------
;; From csimp.lisp
(defmvar $demoivre nil)
(defmvar $nointegrate nil)
(defmvar $lhospitallim 4)
(defmvar $tlimswitch t)
(defmvar $limsubst nil)

(defvar rsn* nil)
(defvar plogabs nil)

;; Simplified shortcuts of constant expressions involving %pi.
(defvar %p%i '((mtimes) $%i $%pi)
  "%pi*%i")
(defvar fourth%pi '((mtimes) ((rat simp) 1 4) $%pi)
  "%pi/4")
(defvar half%pi '((mtimes) ((rat simp) 1 2) $%pi)
  "%pi/2")
(defvar %pi2 '((mtimes) 2 $%pi)
  "2*%pi")
(defvar half%pi3 '((mtimes) ((rat simp) 3 2) $%pi)
  "3/2*%pi")

(defmvar $sumsplitfact t) ;= nil minfactorial is applied after a factocomb.

;;------------------------------------------------------------------------
;; From defint.lisp
(defmvar integerl nil
  "An integer-list for non-atoms found out to be `integer's")

(defmvar nonintegerl nil
  "A non-integer-list for non-atoms found out to be `noninteger's")

;; Not really sure what this is meant to do, but it's used by MTORAT,
;; KEYHOLE, and POLELIST.
(defvar *semirat* nil)

;;------------------------------------------------------------------------
;; From displa.lisp
(defmvar $ttyoff nil)

(defmvar $display2d t
  "Causes equations to be drawn in two dimensions.  Otherwise, drawn
	 linearly.")

(defmvar $lispdisp nil
  "Causes symbols not having $ as the first character in their pnames
	 to be preceded with a ? when displayed.")

(defmvar $derivabbrev nil)

(defmvar $stringdisp nil
  "Causes strings to be bracketed in double quotes when displayed.
	 Normally this is off, but is turned on when a procedure definition is
	 being displayed.")

;; These three variables are bound within Macsyma Listeners since they are different
;; for each window.  Set them here, anyway, so that RETRIEVE can be called from
;; top level.  The size of TOP-WINDOW is wired in here.

(defmvar $linel 79.)
(defvar linel 79.)
(defvar ttyheight 24.)

(defmvar $known_index_properties '((mlist) $presubscript $presuperscript $postsubscript $postsuperscript))

(defvar *display-labels-p* t)

;;------------------------------------------------------------------------
;; From dskfn.lisp
(defmvar $packagefile nil)

;;------------------------------------------------------------------------
;; From float.lisp
(defmvar $float2bf t
  "If TRUE, no MAXIMA-ERROR message is printed when a floating point number is
converted to a bigfloat number.")

(defmvar $bftorat nil
  "Controls the conversion of bigfloat numbers to rational numbers.  If
FALSE, RATEPSILON will be used to control the conversion (this results in
relatively small rational numbers).  If TRUE, the rational number generated
will accurately represent the bigfloat.")

(defmvar $bftrunc t
  "If TRUE, printing of bigfloat numbers will truncate trailing zeroes.
  Otherwise, all trailing zeroes are printed.")

(defmvar $fpprintprec 0
  "Controls the number of significant digits printed for floats.  If
  0, then full precision is used."
  fixnum)

(defmvar $maxfpprintprec (ceiling (log (expt 2 (float-digits 1.0)) 10.0))
  "The maximum number of significant digits printed for floats.")

(defmvar $fpprec $maxfpprintprec
  "Number of decimal digits of precision to use when creating new bigfloats.
One extra decimal digit in actual representation for rounding purposes.")

(defmvar bigfloatzero '((bigfloat simp 56.) 0 0)
  "Bigfloat representation of 0" in-core)

(defmvar bigfloatone  '((bigfloat simp 56.) #.(expt 2 55.) 1)
  "Bigfloat representation of 1" in-core)

(defmvar bfhalf	      '((bigfloat simp 56.) #.(expt 2 55.) 0)
  "Bigfloat representation of 1/2")

(defmvar bfmhalf      '((bigfloat simp 56.) #.(- (expt 2 55.)) 0)
  "Bigfloat representation of -1/2")

(defmvar bigfloat%e   '((bigfloat simp 56.) 48968212118944587. 2)
  "Bigfloat representation of %E")

(defmvar bigfloat%pi  '((bigfloat simp 56.) 56593902016227522. 2)
  "Bigfloat representation of %pi")

(defmvar bigfloat%gamma '((bigfloat simp 56.) 41592772053807304. 0)
  "Bigfloat representation of %gamma")

(defmvar bigfloat_log2 '((bigfloat simp 56.) 49946518145322874. 0)
  "Bigfloat representation of log(2)")

;; Number of bits of precision in the mantissa of newly created bigfloats.
;; FPPREC = ($FPPREC+1)*(Log base 2 of 10)

(defvar fpprec)

;;------------------------------------------------------------------------
;; From gamma.lisp
(defmvar $factorial_expand nil)
(defmvar $beta_expand nil)

(defmvar $hypergeometric_representation nil
  "When T a transformation to a hypergeometric representation is done.")

;;------------------------------------------------------------------------
;; From inmis.lisp
(defmvar $listconstvars nil
  "Causes LISTOFVARS to include %E, %PI, %I, and any variables declared
   constant in the list it returns if they appear in exp.  The default is
   to omit these." boolean see-also $listofvars)

;;------------------------------------------------------------------------
;; From macsys.lisp
(defmvar $showtime nil
  "When T, the computation time is printed with each output expression.")

(defmvar $_ '$_ "last thing read in, corresponds to lisp +")
(defmvar $__ '$__ "thing read in which will be evaluated, corresponds to -")

;;------------------------------------------------------------------------
;; From mat.lisp
(defmvar $globalsolve nil)
(defmvar $sparse nil)
(defmvar $backsubst t)

;;------------------------------------------------------------------------
;; From matrix.lisp
(defmvar $detout nil)
(defmvar $ratmx nil)
(defmvar $matrix_element_mult "*")  ;;; Else, most useful when "."
(defmvar $matrix_element_add "+")

;;------------------------------------------------------------------------
;; From mdot.lisp
(defmvar $dotscrules nil
  "Causes a non-commutative product of a scalar and another term to
be simplified to a commutative product.  Scalars and constants are carried
to the front of the expression.")

(defmvar $dotdistrib nil
  "Causes every non-commutative product to be expanded each time it
is simplified, i.e.  A . (B + C) will simplify to A . B + A . C.")

(defmvar $dotexptsimp t "Causes A . A to be simplified to A ^^ 2.")

(defmvar $dotassoc t
  "Causes a non-commutative product to be considered associative, so
that A . (B . C) is simplified to A . B . C.  If this flag is off, dot is
taken to be right associative, i.e.  A . B . C is simplified to A . (B . C).")

(defmvar $doallmxops t
  "Causes all operations relating to matrices (and lists) to be
carried out.  For example, the product of two matrices will actually be
computed rather than simply being returned.  Turning on this switch
effectively turns on the following three.")

(defmvar $domxmxops t "Causes matrix-matrix operations to be carried out.")

(defmvar $doscmxops nil "Causes scalar-matrix operations to be carried out.")

(defmvar $scalarmatrixp t
  "Causes a square matrix of dimension one to be converted to a
scalar, i.e. its only element.")

(defmvar $assumescalar t
  "This governs whether unknown expressions 'exp' are assumed to behave
like scalars for combinations of the form 'exp op matrix' where op is one of
{+, *, ^, .}.  It has three settings:

FALSE -- such expressions behave like non-scalars.
TRUE  -- such expressions behave like scalars only for the commutative
	 operators but not for non-commutative multiplication.
ALL   -- such expressions will behave like scalars for all operators
	 listed above.

Note:  This switch is primarily for the benefit of old code.  If possible,
you should declare your variables to be SCALAR or NONSCALAR so that there
is no need to rely on the setting of this switch.")

;;------------------------------------------------------------------------
;; From merror.lisp
(defmvar $error `((mlist simp) "No error.")
  "During an MAXIMA-ERROR break this is bound to a list
  of the arguments to the call to MAXIMA-ERROR, with the message
  text in a compact format.")

(defmvar $errormsg 't
  "If `false' then no maxima-error message is printed!")

;;------------------------------------------------------------------------
;; From mlisp.lisp
(defvar featurel
  '($integer $noninteger $even $odd $rational $irrational $real $imaginary $complex
    $analytic $increasing $decreasing $oddfun $evenfun $posfun $constant
    $commutative $lassociative $rassociative $symmetric $antisymmetric
    $integervalued))

(defmvar $features (cons '(mlist simp) (append featurel nil)))
(defmvar $%enumer nil)
(defmvar $float nil
  ;; From hayat.lisp
  "Indicates whether to convert rational numbers to floating point
  numbers.")
(defmvar $translate nil)
(defmvar $transrun t)
(defmvar $savedef t)
(defmvar $infeval nil)
(defmvar $piece '$piece)

;; These three variables are what get stuck in array slots as magic
;; unbound objects.  They are for T, FIXNUM, and FLONUM type arrays
;; respectively.

(defvar munbound '|#####|)
(defvar fixunbound most-negative-fixnum)
(defvar flounbound most-negative-flonum)

(defmvar munbindp nil
  "Used for safely `munbind'ing incorrectly-bound variables."
  no-reset)

(defmvar $setcheck nil)

;;Function Call stack each element is
;; (fname . bindlist) where bindlist was the value at time of entry.
;; So you can use this to compute what the bindings were at any
;; function call.
(defvar *mlambda-call-stack* (make-array 30 :fill-pointer 0 :adjustable t ))

(defvar $structures '((mlist)))

;; If this is T then arrays are stored in the value cell,
;; whereas if it is false they are stored in the function cell
(defmvar $use_fast_arrays nil)

(defvar bindlist nil)
(defvar loclist nil)
(defvar *nounl* nil)
(defvar scanmapp nil)
(defvar maplp nil)
(defvar evp nil)
(defvar mlocp nil)
(defvar fmaplvl 0)
(defvar aryp nil)
(defvar msump nil)
(defvar evarrp nil)
(defvar factlist nil)
(defvar *nounsflag* nil)
(defvar transp nil)
(defvar noevalargs nil)

;;------------------------------------------------------------------------
;; From mload.lisp
(defmvar $load_pathname nil
  "The full pathname of the file being loaded")

(defvar *maxima-testsdir*)

;;------------------------------------------------------------------------
;; From nforma.lisp
(defmvar $powerdisp nil)
(defmvar $pfeformat nil)
(defmvar $%edispflag nil)
(defmvar $sqrtdispflag t)

;;------------------------------------------------------------------------
;; From rat3b.lisp
(defmvar $ratwtlvl nil) 
(defmvar $ratalgdenom t)       ;If T then denominator is rationalized.

;;------------------------------------------------------------------------
