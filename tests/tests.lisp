(in-package "MAXIMA") 

(set-pathnames)

;(load (pathname "../src/nusum"))
;(load (pathname "../src/ode2"))
;(load (pathname "../src/elim"))
;(load (pathname "../src/trgsmp"))

#+gmp (si::set-gmp-allocate-relocatable t)

(setf (get 'maxima::%cosh 'maxima::translated) t);;so that kill won't remprop.

;(dolist (v  '(|nusum| |ode2| |elim| |trgsmp|)) (aload v))

;; bang on sgc if we have it.
;#+sgc (si::sgc-on t)
;; allocate some more space..
;#+gcl (progn (si::allocate-relocatable-pages 2000 t) (si::allocate 'cfun 200 t)  (si::allocate 'fixnum 200 t) (si::allocate 'cons 400 t) (si::allocate 'symbol 100 t))


;; bang on relocatable bignums
#+gmp(si::set-gmp-allocate-relocatable t)

;;we won't bother collecting the errors

(setq *collect-errors* nil)
(time 
  (sloop with errs = '((mlist)) for v in 
	 '(
	   "rtest1" "rtest1a" "rtest2" "rtest3" "rtest4" "rtest5"
	   "rtest6" "rtest6a" "rtest6b" "rtest7"
	   "rtest8"
	   "rtest9"
	   "rtest9a" "rtest10" "rtest11" "rtest12" "rtest13" "rtest13s"
	   "rtest14"
	   )
	 do
	 (format t "~%Testing ~a.mac" v)
	 (or (errset
               (setq errs ($append errs
                            (test-batch (format nil
			     "~a~a.mac" (if (boundp 'doc-path) doc-path "")
			     v)))))
	    (progn
              (setq errs ($append errs `((mlist), '$Broke ',v)))
     
	     (format t "~%Caused a error break: ~a.mac" v)))
         finally (cond ((null (cdr errs)) (format t "~%No Errors Found"))
		       (t ($print "Error Summary:" errs)))
	 ))
;;check the run command
;(macsyma-top-level)

























