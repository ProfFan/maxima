;;; -*-  Mode: Lisp; Package: Maxima; Syntax: Common-Lisp; Base: 10 -*- ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     The data in this file contains enhancements.                   ;;;;;
;;;                                                                    ;;;;;
;;;  Copyright (c) 1984,1987 by William Schelter,University of Texas   ;;;;;
;;;     All rights reserved                                            ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     (c) Copyright 1982 Massachusetts Institute of Technology         ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :maxima)

(macsyma-module sinint)

(load-macsyma-macros ratmac)

(declare-top (special checkfactors
		      exp var
		      rootfactor pardenom
		      wholepart parnumer logptdx switch1))

(defun rootfac (q var)
  (prog (nthdq nthdq1 simproots ans n-loops)
     (setq nthdq (pgcd q (pderivative q var)))
     (setq simproots (pquotient q nthdq))
     (setq ans (list (pquotient simproots (pgcd nthdq simproots))))
     (setq n-loops 0)
   amen
     (cond
       ((= n-loops $factor_max_degree)
        (return (list q)))
       ((or (pcoefp nthdq) (pointergp var (car nthdq)))
        (return (reverse ans))))
     (setq nthdq1 (pgcd (pderivative nthdq var) nthdq))
     (push (pquotient (pgcd nthdq simproots) (pgcd nthdq1 simproots)) ans)
     (setq nthdq nthdq1)
     (incf n-loops)
     (go amen)))

(defun aprog (q var)
  (setq q (oldcontent q))
  (setq rootfactor (rootfac (cadr q) var))
  (setq rootfactor
	(cons (ptimes (car q) (car rootfactor)) (cdr rootfactor)))
  (do ((pd (list (car rootfactor)))
       (rf (cdr rootfactor) (cdr rf))
       (n 2 (1+ n)))
      ((null rf) (setq pardenom (reverse pd)))
    (push (pexpt (car rf) n) pd))
  rootfactor)

(defun cprog (top bottom)
  (prog (frpart pardenomc ppdenom thebpg)
     (setq frpart (pdivide top bottom))
     (setq wholepart (car frpart))
     (setq frpart (cadr frpart))
     (if (= (length pardenom) 1)
	 (return (setq parnumer (list frpart))))
     (setq pardenomc (cdr pardenom))
     (setq ppdenom (list (car pardenom)))
   dseq
     (if (= (length pardenomc) 1) (go ok))
     (setq ppdenom (cons (ptimes (car ppdenom) (car pardenomc)) ppdenom))
     (setq pardenomc (cdr pardenomc))
     (go dseq)
   ok
     (setq pardenomc (reverse pardenom))
   numc
     (setq thebpg (bprog (car pardenomc) (car ppdenom) var))
     (setq parnumer
	   (cons (cdr (ratdivide (ratti frpart (cdr thebpg) t)
				 (car pardenomc)))
		 parnumer))
     (setq frpart
	   (cdr (ratdivide (ratti frpart (car thebpg) t)
			   (car ppdenom))))
     (setq pardenomc (cdr pardenomc))
     (setq ppdenom (cdr ppdenom))
     (if (null ppdenom)
	 (return (setq parnumer (cons frpart parnumer))))
     (go numc)))

(defun polyint (p var)
  (labels
      ((polyint1 (p var)
	 (cond ((or (null p) (equal p 0)) (cons 0 1))
	       ((atom p) (list var 1 p))
	       ((not (numberp (car p)))
		(if (pointergp var (car p)) (list var 1 p) (polyint1 (cdr p) var)))
	       (t (ratplus (polyint2 p var) (polyint1 (cddr p) var)))))

       (polyint2 (p var)
	 (cons (list var (1+ (car p)) (cadr p)) (1+ (car p)))))
    (ratqu (polyint1 (ratnumerator p) var)
	   (ratdenominator p))))
	 

(defun dprog (ratarg sinint-ratform var)
  (prog (klth kx arootf deriv thebpg thetop thebot prod1 prod2 ans)
     (setq ans (cons 0 1))
     (if (or (pcoefp (cdr ratarg)) (pointergp var (cadr ratarg)))
	 (return (disrep (polyint ratarg var) sinint-ratform)))
     (aprog (ratdenominator ratarg) var)
     (cprog (ratnumerator ratarg) (ratdenominator ratarg))
     (setq rootfactor (reverse rootfactor))
     (setq parnumer (reverse parnumer))
     (setq klth (length rootfactor))
   intg
     (if (= klth 1) (go simp))
     (setq arootf (car rootfactor))
     (if (zerop (pdegree arootf var)) (go reset))
     (setq deriv (pderivative arootf var))
     (setq thebpg (bprog arootf deriv var))
     (setq kx (1- klth))
     (setq thetop (car parnumer))
   iter
     (setq prod1 (ratti thetop (car thebpg) t))
     (setq prod2 (ratti thetop (cdr thebpg) t))
     (setq thebot (pexpt arootf kx))
     (setq ans
	   (ratplus ans (ratqu (ratminus prod2) (ratti kx thebot t))))
     (setq thetop
	   (ratplus prod1
		    (ratqu (ratreduce (pderivative (car prod2) var)
				      (cdr prod2))
			   kx)))
     (setq thetop (cdr (ratdivide thetop thebot)))
     (cond ((= kx 1) (setq logptdx (cons (ratqu thetop arootf) logptdx))
	    (go reset)))
     (setq kx (1- kx))
     (go iter)
   reset
     (setq rootfactor (cdr rootfactor))
     (setq parnumer (cdr parnumer))
     (decf klth)
     (go intg)
   simp
     (push (ratqu (car parnumer) (car rootfactor)) logptdx)
     (if (equal ans 0) (return (disrep (polyint wholepart var) sinint-ratform)))
     (setq thetop
	   (cadr (pdivide (ratnumerator ans) (ratdenominator ans))))
     (return (list '(mplus)
		   (disrep (polyint wholepart var) sinint-ratform)
		   (disrep (ratqu thetop (ratdenominator ans)) sinint-ratform)))))

(defun logmabs (x)
  (list '(%log) (if $logabs (simplify (list '(mabs) x)) x)))

(defun npask (exp)
  (cond ((freeof '$%i exp)
	 (learn `((mnotequal) ,exp 0) t) (asksign exp))
	(t '$positive)))

(defvar $integrate_use_rootsof nil "Use the rootsof form for integrals when denominator does not factor")

(defun integrate-use-rootsof (f q variable sinint-ratform)
  (let ((dummy (make-param))
	(qprime (disrep (pderivative q (p-var q)) sinint-ratform))
	(ff (disrep f sinint-ratform))
	(qq (disrep q sinint-ratform)))
    ;; This basically does a partial fraction expansion and integrates
    ;; the result.  Let r be one (simple) root of the denominator
    ;; polynomial q.  Then the partial fraction expansion is
    ;;
    ;;   f(x)/q(x) = A/(x-r) + similar terms.
    ;;
    ;; Then
    ;;
    ;;   f(x) = A*q(x)/(x-r) + others
    ;;
    ;; Take the limit as x -> r.
    ;;
    ;;   f(r) = A*limit(q(x)/(x-r),x,r) + others
    ;;        = A*at(diff(q(x),r), [x=r])
    ;;
    ;; Hence, A = f(r)/at(diff(q(x),x),[x=r])
    ;;
    ;; Then it follows that the integral is
    ;;
    ;;    A*log(x-r)
    ;;
    ;; Note that we don't express the polynomial in terms of the
    ;; variable of integration, but in our dummy variable instead.
    ;; Using the variable of integration results in a wrong answer
    ;; when a substitution was done previously, since when the
    ;; substitution is finally undone, that modifies the polynomial.
    `((%lsum) ((mtimes)
	       ,(div* (subst dummy variable ff)
		      (subst dummy variable qprime))
	       ((%log) ,(sub* variable dummy)))
      ,dummy
      (($rootsof) ,(subst dummy variable qq) ,dummy))))

(defun eprog (p sinint-ratform var)
  (prog (p1e p2e a1e a2e a3e discrim repart sign ncc dcc allcc xx deg)
     (if (or (equal p 0) (equal (car p) 0)) (return 0))
     (setq p1e (ratnumerator p) p2e (ratdenominator p))
     (cond ((or switch1
		(and (not (atom p2e))
		     (eq (car (setq xx (cadr (oldcontent p2e)))) var)
		     (member (setq deg (pdegree xx var)) '(5 6) :test #'equal)
		     (zerocoefl xx deg)
		     (or (equal deg 5) (not (pminusp (car (last xx)))))))
	    (go efac)))
     (setq a1e (intfactor p2e))
     (if (> (length a1e) 1) (go e40))
   efac
     (setq ncc (oldcontent p1e))
     (setq p1e (cadr ncc))
     (setq dcc (oldcontent p2e))
     (setq p2e (cadr dcc))
     (setq allcc (ratqu (car ncc) (car dcc)))
     (setq deg (pdegree p2e var))
     (setq a1e (pderivative p2e var))
     (setq a2e (ratqu (polcoef p1e (pdegree p1e var) var)
		      (polcoef a1e (pdegree a1e var) var)))
     (cond ((equal (ratti a2e a1e t) (cons p1e 1))
	    (return (list '(mtimes)
			  (disrep (ratti allcc a2e t) sinint-ratform )
			  (logmabs (disrep p2e sinint-ratform))))))
     (cond ((equal deg 1) (go e10))
	   ((equal deg 2) (go e20))
	   ((and (equal deg 3) (equal (polcoef p2e 2 var) 0)
		 (equal (polcoef p2e 1 var) 0))
	    (return (e3prog p1e p2e allcc sinint-ratform)))
	   ((and (member deg '(4 5 6) :test #'equal) (zerocoefl p2e deg))
	    (return (enprog p1e p2e allcc deg sinint-ratform))))
     (cond ((and $integrate_use_rootsof (equal (car (psqfr p2e)) p2e))
	    (return (list '(mtimes) (disrep allcc sinint-ratform)
			  (integrate-use-rootsof p1e p2e
						 (car (last varlist))
						 sinint-ratform)))))
     (return (list '(mtimes)
		   (disrep allcc sinint-ratform)
		   (list '(%integrate)
			 (list '(mquotient) (disrep p1e  sinint-ratform) (disrep p2e sinint-ratform))
			 (car (last varlist)))))
   e10
     (return (list '(mtimes)
		      (disrep (ratti allcc
				     (ratqu (polcoef p1e (pdegree p1e var) var)
					    (polcoef p2e 1 var))
				     t)
			      sinint-ratform)
		      (logmabs (disrep p2e sinint-ratform))))
   e20
     (setq discrim
	      (ratdifference (cons (pexpt (polcoef p2e 1 var) 2) 1)
			     (ratti 4 (ratti (polcoef p2e 2 var) (polcoef p2e 0 var) t) t)))
     (setq a2e (ratti (polcoef p2e (pdegree p2e var) var) 2 t))
     (setq xx (simplify (disrep discrim sinint-ratform)))
     (when (equal ($imagpart xx) 0)
       (setq sign (npask xx))
       (cond ((eq sign '$negative) (go e30))
	     ((eq sign '$zero) (go zip))))
     (setq a1e (ratsqrt discrim sinint-ratform))
     (setq a3e (logmabs
		(list '(mquotient)
		      (list '(mplus)
			    (list '(mtimes)
				  (disrep a2e  sinint-ratform) (disrep (list var 1 1) sinint-ratform))
			    (disrep (polcoef p2e 1 var) sinint-ratform)
			    (list '(mminus) a1e))
		      (list '(mplus)
			    (list '(mtimes)
				  (disrep a2e sinint-ratform) (disrep (list var 1 1) sinint-ratform))
			    (disrep (polcoef p2e 1 var) sinint-ratform)
			    a1e))))
     (cond ((zerop (pdegree p1e var))
	    (return (list '(mtimes)
			  (disrep allcc sinint-ratform)
			  (list '(mquotient) (disrep (polcoef p1e 0 var) sinint-ratform) a1e)
			  a3e))))
     (return
       (list
	'(mplus)
	(list '(mtimes)
	      (disrep (ratti allcc (ratqu (polcoef p1e (pdegree p1e var) var) a2e) t)
		      sinint-ratform)
	      (logmabs (disrep p2e sinint-ratform)))
	(list
	 '(mtimes)
	 (list
	  '(mquotient)
	  (disrep (ratti allcc (ratqu (eprogratd a2e p1e p2e) a2e) t)
		  sinint-ratform)
	  a1e)
	 a3e)))
   e30
     (setq a1e (ratsqrt (ratminus discrim) sinint-ratform))
     (setq
      repart
      (ratqu (cond ((zerop (pdegree p1e var)) (ratti a2e (polcoef p1e 0 var) t))
		   (t (eprogratd a2e p1e p2e)))
	     (polcoef p2e (pdegree p2e var) var)))
     (setq a3e (cond ((equal 0 (car repart)) 0)
		     (t `((mtimes) ((mquotient)
				    ,(disrep (ratti allcc repart t) sinint-ratform)
				    ,a1e)
			  ((%atan)
			   ((mquotient)
			    ,(disrep (pderivative p2e var) sinint-ratform)
			    ,a1e))))))
     (if (zerop (pdegree p1e var)) (return a3e))
     (return (list '(mplus)
		   (list '(mtimes)
			 (disrep (ratti allcc
					(ratqu (polcoef p1e (pdegree p1e var) var) a2e)
					t)
				 sinint-ratform)
			 (logmabs (disrep p2e sinint-ratform)))
		   a3e))
   zip
     (setq
	 p2e
	 (ratqu
	  (psimp
	   (p-var p2e)
	   (pcoefadd 2 
		     (pexpt (ptimes 2 (polcoef p2e 2 var)) 2)
		     (pcoefadd 1 (ptimes 4 (ptimes (polcoef p2e 2 var)
						   (polcoef p2e 1 var)))
			       (pcoefadd 0 (pexpt (polcoef p2e 1 var) 2) ()))))
	  (ptimes 4 (polcoef p2e 2 var))))
     (return (fprog (ratti allcc (ratqu p1e p2e) t) sinint-ratform var))
   e40
     (setq parnumer nil pardenom a1e switch1 t)
     (cprog p1e p2e)
     (setq a2e
	   (mapcar #'(lambda (j k) (eprog (ratqu j k) sinint-ratform var)) parnumer pardenom))
     (setq switch1 nil)
     (return (cons '(mplus) a2e))))
 
(defun e3prog (num denom cont sinint-ratform)
  (prog (a b c d e r ratr var* x)
     (setq a (polcoef num 2 var) b (polcoef num 1 var) c (polcoef num 0 var)
	   d (polcoef denom 3 var) e (polcoef denom 0 var))
     (setq r (cond ((eq (npask (simplify (disrep (ratqu e d) sinint-ratform))) '$negative)
		    (simpnrt (disrep (ratqu (ratti -1 e t) d) sinint-ratform) 3))
		   (t (neg (simpnrt (disrep (ratqu e d) sinint-ratform) 3)))))
     (setq var* (list var 1 1))
     (newvar r)
     (orderpointer varlist)
     (setq x (ratf r))
     (setq sinint-ratform (car x) ratr (cdr x))
     (return
       (simplify
	(list '(mplus)
	      (list '(mtimes)
		    (disrep (ratqu (r* cont (r+ (r* a ratr ratr) (r* b ratr) c))
				   (r* ratr ratr 3 d))
			    sinint-ratform)
		    (logmabs (disrep (ratpl (ratti -1 ratr t) var*) sinint-ratform)))
	      (eprog (r* cont (ratqu (r+ (r* (r+ (r* 2 a ratr ratr)
						 (r* -1 b ratr)
						 (r* -1 c))
					     var*)
					 (r+ (ratqu (r* -1 a e) d)
					     (r* b ratr ratr)
					     (r* -1 2 c ratr)))
				     (r* 3 d ratr ratr
					 (r+ (ratti var* var* t)
					     (ratti ratr var* t)
					     (ratti ratr ratr t)))))
		     sinint-ratform
		     var)
	      )))))

(defun eprogratd (a2e p1e p2e)
  (ratdifference (ratti a2e (polcoef p1e (1- (pdegree p1e var)) var) t)
		 (ratti (polcoef p2e (1- (pdegree p2e var)) var)
			(polcoef p1e (pdegree p1e var) var)
			t)))

(defun enprog (num denom cont deg sinint-ratform)
  ;; Denominator is (A*VAR^4+B) = 
  ;;   if B<0 then (SQRT(A)*VAR^2 - SQRT(-B)) (SQRT(A)*VAR^2 + SQRT(-B))
  ;;	     else
  ;;	(SQRT(A)*VAR^2 - SQRT(2)*A^(1/4)*B^(1/4)*VAR + SQRT(B)) * 
  ;;	(SQRT(A)*VAR^2 + SQRT(2)*A^(1/4)*B^(1/4)*VAR + SQRT(B))
  ;; or (A*VAR^5+B) = 
  ;;	(1/4) * (A^(1/5)*VAR + B^(1/5)) *
  ;;	(2*A^(2/5)*VAR^2 + (-SQRT(5)-1)*A^(1/5)*B^(1/5)*VAR + 2*B^(2/5)) *
  ;;	(2*A^(2/5)*VAR^2 + (+SQRT(5)-1)*A^(1/5)*B^(1/5)*VAR + 2*B^(2/5))
  ;; or (A*VAR^6+B) = 
  ;;   if B<0 then (SQRT(A)*VAR^3 - SQRT(-B)) (SQRT(A)*VAR^3 + SQRT(-B))
  ;;	     else
  ;;	(A^(1/3)*VAR^2 + B^(1/3)) *
  ;;	(A^(1/3)*VAR^2 - SQRT(3)*A^(1/6)*B^(1/6)*VAR + B^(1/3)) *
  ;;	(A^(1/3)*VAR^2 + SQRT(3)*A^(1/6)*B^(1/6)*VAR + B^(1/3))
  (prog ($expop $expon a b term disvar $algebraic)
     (setq $expop 0 $expon 0)
     (setq a (simplify (disrep (polcoef denom deg var) sinint-ratform))
	   b (simplify (disrep (polcoef denom 0 var) sinint-ratform))
	   disvar (simplify (get var 'disrep))
	   num (simplify (disrep num sinint-ratform))
	   cont (simplify (disrep cont sinint-ratform)))
     (cond ((= deg 4)
	    (if (eq '$neg ($asksign b))
		(setq denom
		      (mul2 (add2 (mul2 (power a '((rat simp) 1 2)) (power disvar 2))
				  (power (mul -1 b) '((rat simp) 1 2)))
			    (add2 (mul2 (power a '((rat simp) 1 2)) (power disvar 2))
				  (mul -1 (power (mul -1 b) '((rat simp) 1 2))))))
		(progn
		  (setq denom (add2 (mul2 (power a '((rat simp) 1 2)) (power disvar 2))
				    (power b '((rat simp) 1 2)))
			term (muln (list (power 2 '((rat simp) 1 2))
					 (power a '((rat simp) 1 4))
					 (power b '((rat simp) 1 4))
					 disvar)
				   t))
		  (setq denom (mul2 (add2 denom term) (sub denom term))))))
	   ((= deg 5)
	    (setq term (mul3 (power a '((rat simp) 1 5))
			     (power b '((rat simp) 1 5))
			     disvar))
	    (setq denom (add2 (mul3 2 (power a '((rat simp) 2 5))
				    (power disvar 2))
			      (sub (mul2 2 (power b '((rat simp) 2 5))) term)))
	    (setq term (mul2 (power 5 '((rat simp) 1 2)) term))
	    (setq denom (muln (list '((rat simp) 1 4)
				    (add2 (mul2 (power a '((rat simp) 1 5)) disvar)
					  (power b '((rat simp) 1 5)))
				    (add2 denom term) (sub denom term))
			      t)))
	   (t
	    (if (eq '$neg ($asksign b))
		(setq denom
		      (mul2 (add2 (mul2 (power a '((rat simp) 1 2)) (power disvar 3))
				  (power (mul -1 b) '((rat simp) 1 2)))
			    (add2 (mul2 (power a '((rat simp) 1 2)) (power disvar 3))
				  (mul -1 (power (mul -1 b) '((rat simp) 1 2))))))
		(progn
		  (setq denom (add2 (mul2 (power a '((rat simp) 1 3)) (power disvar 2))
				    (power b '((rat simp) 1 3)))
			term (muln (list (power 3 '((rat simp) 1 2))
					 (power a '((rat simp) 1 6))
					 (power b '((rat simp) 1 6))
					 disvar)
				   t))
		  (setq denom (mul3 denom (add2 denom term) (sub denom term))))
		)))
     ;;Needs $ALGEBRAIC NIL so next call to RATF will preserve factorization.
     (return (mul2 cont (ratint (div num denom) disvar)))))

(defun zerocoefl (e n)
  (do ((i 1 (1+ i))) ((= i n) t)
    (if (not (equal (polcoef e i var) 0)) (return nil))))

(defun ratsqrt (a sinint-ratform)
  (let (varlist)
    (simpnrt (disrep a sinint-ratform) 2)))

(defun fprog (rat* sinint-ratform var)
  (prog (rootfactor pardenom parnumer logptdx wholepart switch1)
     (return (addn (cons (dprog rat* sinint-ratform var)
			 (mapcar #'(lambda (p)
				     (eprog p sinint-ratform var))
				 logptdx))
		   nil))))

(defun ratint (exp var)
  (prog (genvar checkfactors varlist ratarg $keepfloat)
     (setq varlist (list var))
     (setq ratarg (ratf exp))
     (setq sinint-ratform (car ratarg))
     (setq var (caadr (ratf var)))
     (return (fprog (cdr ratarg) sinint-ratform var))))

(defun intfactor (l)
  (labels ((everysecond (a)
	     (if a (cons (if (numberp (car a))
			     (pexpt (car a) (cadr a))
			     (car a))
			 (everysecond (cddr a))))))
	   
    (prog ($factorflag a b)
       (setq a (oldcontent l) b (everysecond (pfactor (cadr a))))
       (return (if (equal (car a) 1) b (cons (car a) b))))))
