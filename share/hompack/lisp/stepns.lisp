;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl2.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 95098eb54f13 2013/04/01 00:45:16 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v 1409c1352feb 2013/03/24 20:44:50 toy $")

;;; Using Lisp CMU Common Lisp snapshot-2020-04 (21D Unicode)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))

(in-package "HOMPACK")


(let* ((litfh 4))
  (declare (type (f2cl-lib:integer4 4 4) litfh) (ignorable litfh))
  (defun stepns
         (n nfe iflag start crash hold h relerr abserr s y yp yold ypold a qr
          lenqr pivot work sspar par ipar)
    (declare (type (array f2cl-lib:integer4 (*)) ipar)
             (type (array double-float (*)) par)
             (type (array double-float (*)) sspar)
             (type (array f2cl-lib:integer4 (*)) pivot)
             (type (array double-float (*)) work qr a ypold yold yp y)
             (type (double-float) s abserr relerr h hold)
             (type f2cl-lib:logical crash start)
             (type (f2cl-lib:integer4) lenqr iflag nfe n))
    (f2cl-lib:with-multi-array-data
        ((y double-float y-%data% y-%offset%)
         (yp double-float yp-%data% yp-%offset%)
         (yold double-float yold-%data% yold-%offset%)
         (ypold double-float ypold-%data% ypold-%offset%)
         (a double-float a-%data% a-%offset%)
         (qr double-float qr-%data% qr-%offset%)
         (work double-float work-%data% work-%offset%)
         (pivot f2cl-lib:integer4 pivot-%data% pivot-%offset%)
         (sspar double-float sspar-%data% sspar-%offset%)
         (par double-float par-%data% par-%offset%)
         (ipar f2cl-lib:integer4 ipar-%data% ipar-%offset%))
      (labels ((dd01 (f0 f1 dels)
                 (f2cl-lib:f2cl/ (+ f1 (- f0)) dels))
               (dd001 (f0 fp0 f1 dels)
                 (/ (- (dd01 f0 f1 dels) fp0) dels))
               (dd011 (f0 f1 fp1 dels)
                 (/ (- fp1 (dd01 f0 f1 dels)) dels))
               (dd0011 (f0 fp0 f1 fp1 dels)
                 (/ (- (dd011 f0 f1 fp1 dels) (dd001 f0 fp0 f1 dels)) dels))
               (qofs (f0 fp0 f1 fp1 dels s)
                 (+
                  (*
                   (+
                    (*
                     (+ (* (dd0011 f0 fp0 f1 fp1 dels) (- s dels))
                        (dd001 f0 fp0 f1 dels))
                     s)
                    fp0)
                   s)
                  f0)))
        (declare (ftype (function (double-float double-float double-float)
                         (values double-float &rest t))
                        dd01))
        (declare (ftype (function
                         (double-float double-float double-float double-float)
                         (values double-float &rest t))
                        dd001))
        (declare (ftype (function
                         (double-float double-float double-float double-float)
                         (values double-float &rest t))
                        dd011))
        (declare (ftype (function
                         (double-float double-float double-float double-float
                          double-float)
                         (values double-float &rest t))
                        dd0011))
        (declare (ftype (function
                         (double-float double-float double-float double-float
                          double-float double-float)
                         (values double-float &rest t))
                        qofs))
        (prog ((fail nil) (ipp 0) (irho 0) (itangw 0) (itnum 0) (itz 0) (iw 0)
               (iwp 0) (iz0 0) (iz1 0) (j 0) (judy 0) (np1 0) (dcalc 0.0d0)
               (dels 0.0d0) (f0 0.0d0) (f1 0.0d0) (fouru 0.0d0) (fp0 0.0d0)
               (fp1 0.0d0) (hfail 0.0d0) (ht 0.0d0) (lcalc 0.0d0) (rcalc 0.0d0)
               (rholen 0.0d0) (temp 0.0d0) (twou 0.0d0))
          (declare (type f2cl-lib:logical fail)
                   (type (f2cl-lib:integer4) ipp irho itangw itnum itz iw iwp
                                             iz0 iz1 j judy np1)
                   (type (double-float) dcalc dels f0 f1 fouru fp0 fp1 hfail ht
                                        lcalc rcalc rholen temp twou))
          (setf twou (* 2.0 (f2cl-lib:d1mach 4)))
          (setf fouru (+ twou twou))
          (setf np1 (f2cl-lib:int-add n 1))
          (setf ipp 1)
          (setf irho (f2cl-lib:int-add n 1))
          (setf iw (f2cl-lib:int-add irho n))
          (setf iwp (f2cl-lib:int-add iw np1))
          (setf itz (f2cl-lib:int-add iwp np1))
          (setf iz0 (f2cl-lib:int-add itz np1))
          (setf iz1 (f2cl-lib:int-add iz0 np1))
          (setf itangw (f2cl-lib:int-add iz1 np1))
          (setf crash f2cl-lib:%true%)
          (if (< s 0.0) (go end_label))
          (cond
            ((< h (* fouru (+ 1.0 s)))
             (setf h (* fouru (+ 1.0 s)))
             (go end_label)))
          (setf temp (dnrm2 np1 y 1))
          (if (>= (* 0.5 (+ (* relerr temp) abserr)) (* twou temp))
              (go label40))
          (cond
            ((/= relerr 0.0)
             (setf relerr (* fouru (+ 1.0 fouru)))
             (setf abserr (max abserr 0.0d0)))
            (t
             (setf abserr (* fouru temp))))
          (go end_label)
         label40
          (setf crash f2cl-lib:%false%)
          (if (not start) (go label300))
          (setf fail f2cl-lib:%false%)
          (setf start f2cl-lib:%false%)
          (setf h
                  (min h
                       0.1d0
                       (f2cl-lib:fsqrt
                        (f2cl-lib:fsqrt (+ (* relerr temp) abserr)))))
          (setf (f2cl-lib:fref ypold-%data%
                               (np1)
                               ((1 (f2cl-lib:int-add n 1)))
                               ypold-%offset%)
                  (coerce 1.0 'double-float))
          (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                        ((> j n) nil)
            (tagbody
              (setf (f2cl-lib:fref ypold-%data%
                                   (j)
                                   ((1 (f2cl-lib:int-add n 1)))
                                   ypold-%offset%)
                      (coerce 0.0 'double-float))
             label50))
          (multiple-value-bind
                (var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8 var-9
                 var-10 var-11 var-12 var-13 var-14 var-15 var-16)
              (tangns s y yp
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (itz)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               ypold a qr lenqr pivot
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (ipp)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (irho)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (itangw)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               nfe n iflag par ipar)
            (declare (ignore var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8
                             var-9 var-10 var-11 var-13 var-15 var-16))
            (setf s var-0)
            (setf nfe var-12)
            (setf iflag var-14))
          (if (> iflag 0) (go end_label))
         label70
          (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                        ((> j np1) nil)
            (tagbody
              (setf temp
                      (+
                       (f2cl-lib:fref y-%data%
                                      (j)
                                      ((1 (f2cl-lib:int-add n 1)))
                                      y-%offset%)
                       (* h
                          (f2cl-lib:fref yp-%data%
                                         (j)
                                         ((1 (f2cl-lib:int-add n 1)))
                                         yp-%offset%))))
              (setf (f2cl-lib:fref work-%data%
                                   ((f2cl-lib:int-sub (f2cl-lib:int-add iw j)
                                                      1))
                                   ((1
                                     (f2cl-lib:int-add
                                      (f2cl-lib:int-mul 13
                                                        (f2cl-lib:int-add n 1))
                                      (f2cl-lib:int-mul 2 n)
                                      lenqr)))
                                   work-%offset%)
                      temp)
              (setf (f2cl-lib:fref work-%data%
                                   ((f2cl-lib:int-sub (f2cl-lib:int-add iz0 j)
                                                      1))
                                   ((1
                                     (f2cl-lib:int-add
                                      (f2cl-lib:int-mul 13
                                                        (f2cl-lib:int-add n 1))
                                      (f2cl-lib:int-mul 2 n)
                                      lenqr)))
                                   work-%offset%)
                      temp)
             label80))
          (f2cl-lib:fdo (judy 1 (f2cl-lib:int-add judy 1))
                        ((> judy litfh) nil)
            (tagbody
              (setf rholen (coerce -1.0 'double-float))
              (multiple-value-bind
                    (var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8
                     var-9 var-10 var-11 var-12 var-13 var-14 var-15 var-16)
                  (tangns rholen
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (iw)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (iwp)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (itz)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   ypold a qr lenqr pivot
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (ipp)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (irho)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (itangw)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   nfe n iflag par ipar)
                (declare (ignore var-1 var-2 var-3 var-4 var-5 var-6 var-7
                                 var-8 var-9 var-10 var-11 var-13 var-15
                                 var-16))
                (setf rholen var-0)
                (setf nfe var-12)
                (setf iflag var-14))
              (if (> iflag 0) (go end_label))
              (daxpy np1 1.0d0
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (itz)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               1
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (iw)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               1)
              (setf itnum judy)
              (cond
                ((= judy 1)
                 (setf lcalc
                         (dnrm2 np1
                          (f2cl-lib:array-slice work-%data%
                                                double-float
                                                (itz)
                                                ((1
                                                  (f2cl-lib:int-add
                                                   (f2cl-lib:int-mul 13
                                                                     (f2cl-lib:int-add
                                                                      n
                                                                      1))
                                                   (f2cl-lib:int-mul 2 n)
                                                   lenqr)))
                                                work-%offset%)
                          1))
                 (setf rcalc rholen)
                 (dcopy np1
                  (f2cl-lib:array-slice work-%data%
                                        double-float
                                        (iw)
                                        ((1
                                          (f2cl-lib:int-add
                                           (f2cl-lib:int-mul 13
                                                             (f2cl-lib:int-add
                                                              n
                                                              1))
                                           (f2cl-lib:int-mul 2 n)
                                           lenqr)))
                                        work-%offset%)
                  1
                  (f2cl-lib:array-slice work-%data%
                                        double-float
                                        (iz1)
                                        ((1
                                          (f2cl-lib:int-add
                                           (f2cl-lib:int-mul 13
                                                             (f2cl-lib:int-add
                                                              n
                                                              1))
                                           (f2cl-lib:int-mul 2 n)
                                           lenqr)))
                                        work-%offset%)
                  1))
                ((= judy 2)
                 (setf lcalc
                         (/
                          (dnrm2 np1
                           (f2cl-lib:array-slice work-%data%
                                                 double-float
                                                 (itz)
                                                 ((1
                                                   (f2cl-lib:int-add
                                                    (f2cl-lib:int-mul 13
                                                                      (f2cl-lib:int-add
                                                                       n
                                                                       1))
                                                    (f2cl-lib:int-mul 2 n)
                                                    lenqr)))
                                                 work-%offset%)
                           1)
                          lcalc))
                 (setf rcalc (/ rholen rcalc))))
              (if
               (<=
                (dnrm2 np1
                 (f2cl-lib:array-slice work-%data%
                                       double-float
                                       (itz)
                                       ((1
                                         (f2cl-lib:int-add
                                          (f2cl-lib:int-mul 13
                                                            (f2cl-lib:int-add n
                                                                              1))
                                          (f2cl-lib:int-mul 2 n)
                                          lenqr)))
                                       work-%offset%)
                 1)
                (+
                 (* relerr
                    (dnrm2 np1
                     (f2cl-lib:array-slice work-%data%
                                           double-float
                                           (iw)
                                           ((1
                                             (f2cl-lib:int-add
                                              (f2cl-lib:int-mul 13
                                                                (f2cl-lib:int-add
                                                                 n
                                                                 1))
                                              (f2cl-lib:int-mul 2 n)
                                              lenqr)))
                                           work-%offset%)
                     1))
                 abserr))
               (go label600))
             label200))
          (cond
            ((<= h (* fouru (+ 1.0 s)))
             (setf iflag 6)
             (go end_label)))
          (setf h (* 0.5 h))
          (go label70)
         label300
          (setf fail f2cl-lib:%false%)
         label320
          (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                        ((> j np1) nil)
            (tagbody
              (setf temp
                      (qofs
                       (f2cl-lib:fref yold-%data%
                                      (j)
                                      ((1 (f2cl-lib:int-add n 1)))
                                      yold-%offset%)
                       (f2cl-lib:fref ypold-%data%
                                      (j)
                                      ((1 (f2cl-lib:int-add n 1)))
                                      ypold-%offset%)
                       (f2cl-lib:fref y-%data%
                                      (j)
                                      ((1 (f2cl-lib:int-add n 1)))
                                      y-%offset%)
                       (f2cl-lib:fref yp-%data%
                                      (j)
                                      ((1 (f2cl-lib:int-add n 1)))
                                      yp-%offset%)
                       hold (+ hold h)))
              (setf (f2cl-lib:fref work-%data%
                                   ((f2cl-lib:int-sub (f2cl-lib:int-add iw j)
                                                      1))
                                   ((1
                                     (f2cl-lib:int-add
                                      (f2cl-lib:int-mul 13
                                                        (f2cl-lib:int-add n 1))
                                      (f2cl-lib:int-mul 2 n)
                                      lenqr)))
                                   work-%offset%)
                      temp)
              (setf (f2cl-lib:fref work-%data%
                                   ((f2cl-lib:int-sub (f2cl-lib:int-add iz0 j)
                                                      1))
                                   ((1
                                     (f2cl-lib:int-add
                                      (f2cl-lib:int-mul 13
                                                        (f2cl-lib:int-add n 1))
                                      (f2cl-lib:int-mul 2 n)
                                      lenqr)))
                                   work-%offset%)
                      temp)
             label330))
          (f2cl-lib:fdo (judy 1 (f2cl-lib:int-add judy 1))
                        ((> judy litfh) nil)
            (tagbody
              (setf rholen (coerce -1.0 'double-float))
              (multiple-value-bind
                    (var-0 var-1 var-2 var-3 var-4 var-5 var-6 var-7 var-8
                     var-9 var-10 var-11 var-12 var-13 var-14 var-15 var-16)
                  (tangns rholen
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (iw)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (iwp)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (itz)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   yp a qr lenqr pivot
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (ipp)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (irho)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (itangw)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   nfe n iflag par ipar)
                (declare (ignore var-1 var-2 var-3 var-4 var-5 var-6 var-7
                                 var-8 var-9 var-10 var-11 var-13 var-15
                                 var-16))
                (setf rholen var-0)
                (setf nfe var-12)
                (setf iflag var-14))
              (if (> iflag 0) (go end_label))
              (daxpy np1 1.0d0
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (itz)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               1
               (f2cl-lib:array-slice work-%data%
                                     double-float
                                     (iw)
                                     ((1
                                       (f2cl-lib:int-add
                                        (f2cl-lib:int-mul 13
                                                          (f2cl-lib:int-add n
                                                                            1))
                                        (f2cl-lib:int-mul 2 n)
                                        lenqr)))
                                     work-%offset%)
               1)
              (setf itnum judy)
              (cond
                ((= judy 1)
                 (setf lcalc
                         (dnrm2 np1
                          (f2cl-lib:array-slice work-%data%
                                                double-float
                                                (itz)
                                                ((1
                                                  (f2cl-lib:int-add
                                                   (f2cl-lib:int-mul 13
                                                                     (f2cl-lib:int-add
                                                                      n
                                                                      1))
                                                   (f2cl-lib:int-mul 2 n)
                                                   lenqr)))
                                                work-%offset%)
                          1))
                 (setf rcalc rholen)
                 (dcopy np1
                  (f2cl-lib:array-slice work-%data%
                                        double-float
                                        (iw)
                                        ((1
                                          (f2cl-lib:int-add
                                           (f2cl-lib:int-mul 13
                                                             (f2cl-lib:int-add
                                                              n
                                                              1))
                                           (f2cl-lib:int-mul 2 n)
                                           lenqr)))
                                        work-%offset%)
                  1
                  (f2cl-lib:array-slice work-%data%
                                        double-float
                                        (iz1)
                                        ((1
                                          (f2cl-lib:int-add
                                           (f2cl-lib:int-mul 13
                                                             (f2cl-lib:int-add
                                                              n
                                                              1))
                                           (f2cl-lib:int-mul 2 n)
                                           lenqr)))
                                        work-%offset%)
                  1))
                ((= judy 2)
                 (setf lcalc
                         (/
                          (dnrm2 np1
                           (f2cl-lib:array-slice work-%data%
                                                 double-float
                                                 (itz)
                                                 ((1
                                                   (f2cl-lib:int-add
                                                    (f2cl-lib:int-mul 13
                                                                      (f2cl-lib:int-add
                                                                       n
                                                                       1))
                                                    (f2cl-lib:int-mul 2 n)
                                                    lenqr)))
                                                 work-%offset%)
                           1)
                          lcalc))
                 (setf rcalc (/ rholen rcalc))))
              (if
               (<=
                (dnrm2 np1
                 (f2cl-lib:array-slice work-%data%
                                       double-float
                                       (itz)
                                       ((1
                                         (f2cl-lib:int-add
                                          (f2cl-lib:int-mul 13
                                                            (f2cl-lib:int-add n
                                                                              1))
                                          (f2cl-lib:int-mul 2 n)
                                          lenqr)))
                                       work-%offset%)
                 1)
                (+
                 (* relerr
                    (dnrm2 np1
                     (f2cl-lib:array-slice work-%data%
                                           double-float
                                           (iw)
                                           ((1
                                             (f2cl-lib:int-add
                                              (f2cl-lib:int-mul 13
                                                                (f2cl-lib:int-add
                                                                 n
                                                                 1))
                                              (f2cl-lib:int-mul 2 n)
                                              lenqr)))
                                           work-%offset%)
                     1))
                 abserr))
               (go label600))
             label500))
          (setf fail f2cl-lib:%true%)
          (setf hfail h)
          (cond
            ((<= h (* fouru (+ 1.0 s)))
             (setf iflag 6)
             (go end_label)))
          (setf h (* 0.5 h))
          (go label320)
         label600
          (dcopy np1 y 1 yold 1)
          (dcopy np1 yp 1 ypold 1)
          (dcopy np1
           (f2cl-lib:array-slice work-%data%
                                 double-float
                                 (iw)
                                 ((1
                                   (f2cl-lib:int-add
                                    (f2cl-lib:int-mul 13
                                                      (f2cl-lib:int-add n 1))
                                    (f2cl-lib:int-mul 2 n)
                                    lenqr)))
                                 work-%offset%)
           1 y 1)
          (dcopy np1
           (f2cl-lib:array-slice work-%data%
                                 double-float
                                 (iwp)
                                 ((1
                                   (f2cl-lib:int-add
                                    (f2cl-lib:int-mul 13
                                                      (f2cl-lib:int-add n 1))
                                    (f2cl-lib:int-mul 2 n)
                                    lenqr)))
                                 work-%offset%)
           1 yp 1)
          (daxpy np1 -1.0d0 yold 1
           (f2cl-lib:array-slice work-%data%
                                 double-float
                                 (iw)
                                 ((1
                                   (f2cl-lib:int-add
                                    (f2cl-lib:int-mul 13
                                                      (f2cl-lib:int-add n 1))
                                    (f2cl-lib:int-mul 2 n)
                                    lenqr)))
                                 work-%offset%)
           1)
          (setf hold
                  (dnrm2 np1
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (iw)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   1))
          (setf s (+ s hold))
         label700
          (daxpy np1 -1.0d0 y 1
           (f2cl-lib:array-slice work-%data%
                                 double-float
                                 (iz0)
                                 ((1
                                   (f2cl-lib:int-add
                                    (f2cl-lib:int-mul 13
                                                      (f2cl-lib:int-add n 1))
                                    (f2cl-lib:int-mul 2 n)
                                    lenqr)))
                                 work-%offset%)
           1)
          (daxpy np1 -1.0d0 y 1
           (f2cl-lib:array-slice work-%data%
                                 double-float
                                 (iz1)
                                 ((1
                                   (f2cl-lib:int-add
                                    (f2cl-lib:int-mul 13
                                                      (f2cl-lib:int-add n 1))
                                    (f2cl-lib:int-mul 2 n)
                                    lenqr)))
                                 work-%offset%)
           1)
          (setf dcalc
                  (dnrm2 np1
                   (f2cl-lib:array-slice work-%data%
                                         double-float
                                         (iz0)
                                         ((1
                                           (f2cl-lib:int-add
                                            (f2cl-lib:int-mul 13
                                                              (f2cl-lib:int-add
                                                               n
                                                               1))
                                            (f2cl-lib:int-mul 2 n)
                                            lenqr)))
                                         work-%offset%)
                   1))
          (if (/= dcalc 0.0)
              (setf dcalc
                      (/
                       (dnrm2 np1
                        (f2cl-lib:array-slice work-%data%
                                              double-float
                                              (iz1)
                                              ((1
                                                (f2cl-lib:int-add
                                                 (f2cl-lib:int-mul 13
                                                                   (f2cl-lib:int-add
                                                                    n
                                                                    1))
                                                 (f2cl-lib:int-mul 2 n)
                                                 lenqr)))
                                              work-%offset%)
                        1)
                       dcalc)))
          (if (= itnum 1) (setf lcalc (coerce 0.0 'double-float)))
          (cond
            ((= (+ lcalc rcalc dcalc) 0.0)
             (setf ht
                     (* (f2cl-lib:fref sspar-%data% (7) ((1 8)) sspar-%offset%)
                        hold)))
            (t
             (setf ht
                     (*
                      (expt
                       (/ 1.0
                          (max
                           (/ lcalc
                              (f2cl-lib:fref sspar-%data%
                                             (1)
                                             ((1 8))
                                             sspar-%offset%))
                           (/ rcalc
                              (f2cl-lib:fref sspar-%data%
                                             (2)
                                             ((1 8))
                                             sspar-%offset%))
                           (/ dcalc
                              (f2cl-lib:fref sspar-%data%
                                             (3)
                                             ((1 8))
                                             sspar-%offset%))))
                       (/ 1.0
                          (f2cl-lib:fref sspar-%data%
                                         (8)
                                         ((1 8))
                                         sspar-%offset%)))
                      hold))))
          (setf h
                  (min
                   (max ht
                        (*
                         (f2cl-lib:fref sspar-%data%
                                        (6)
                                        ((1 8))
                                        sspar-%offset%)
                         hold)
                        (f2cl-lib:fref sspar-%data%
                                       (4)
                                       ((1 8))
                                       sspar-%offset%))
                   (* (f2cl-lib:fref sspar-%data% (7) ((1 8)) sspar-%offset%)
                      hold)
                   (f2cl-lib:fref sspar-%data% (5) ((1 8)) sspar-%offset%)))
          (cond
            ((= itnum 1)
             (setf h (max h hold)))
            ((= itnum litfh)
             (setf h (min h hold))))
          (if fail (setf h (min h hfail)))
          (go end_label)
         end_label
          (return
           (values nil
                   nfe
                   iflag
                   start
                   crash
                   hold
                   h
                   relerr
                   abserr
                   s
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil
                   nil)))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::stepns
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((fortran-to-lisp::integer4) (fortran-to-lisp::integer4)
                        (fortran-to-lisp::integer4) fortran-to-lisp::logical
                        fortran-to-lisp::logical (double-float) (double-float)
                        (double-float) (double-float) (double-float)
                        (array double-float (*)) (array double-float (*))
                        (array double-float (*)) (array double-float (*))
                        (array double-float (*)) (array double-float (*))
                        (fortran-to-lisp::integer4)
                        (array fortran-to-lisp::integer4 (*))
                        (array double-float (*)) (array double-float (*))
                        (array double-float (*))
                        (array fortran-to-lisp::integer4 (*)))
           :return-values '(nil fortran-to-lisp::nfe fortran-to-lisp::iflag
                            fortran-to-lisp::start fortran-to-lisp::crash
                            fortran-to-lisp::hold fortran-to-lisp::h
                            fortran-to-lisp::relerr fortran-to-lisp::abserr
                            fortran-to-lisp::s nil nil nil nil nil nil nil nil
                            nil nil nil nil)
           :calls '(fortran-to-lisp::dcopy fortran-to-lisp::daxpy
                    fortran-to-lisp::tangns fortran-to-lisp::dnrm2
                    fortran-to-lisp::d1mach))))

