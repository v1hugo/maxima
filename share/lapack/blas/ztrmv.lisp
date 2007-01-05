;;; Compiled by f2cl version 2.0 beta Date: 2006/12/21 03:42:11 
;;; Using Lisp CMU Common Lisp CVS Head 2006-12-02 00:15:46 (19D)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "BLAS")


(let* ((zero (f2cl-lib:cmplx 0.0 0.0)))
  (declare (type (f2cl-lib:complex16) zero))
  (defun ztrmv (uplo trans diag n a lda x incx)
    (declare (type (array f2cl-lib:complex16 (*)) x a)
             (type (f2cl-lib:integer4) incx lda n)
             (type (simple-array character (*)) diag trans uplo))
    (f2cl-lib:with-multi-array-data
        ((uplo character uplo-%data% uplo-%offset%)
         (trans character trans-%data% trans-%offset%)
         (diag character diag-%data% diag-%offset%)
         (a f2cl-lib:complex16 a-%data% a-%offset%)
         (x f2cl-lib:complex16 x-%data% x-%offset%))
      (prog ((noconj nil) (nounit nil) (i 0) (info 0) (ix 0) (j 0) (jx 0)
             (kx 0) (temp #C(0.0 0.0)))
        (declare (type f2cl-lib:logical noconj nounit)
                 (type (f2cl-lib:integer4) i info ix j jx kx)
                 (type (f2cl-lib:complex16) temp))
        (setf info 0)
        (cond
          ((and (not (lsame uplo "U")) (not (lsame uplo "L")))
           (setf info 1))
          ((and (not (lsame trans "N"))
                (not (lsame trans "T"))
                (not (lsame trans "C")))
           (setf info 2))
          ((and (not (lsame diag "U")) (not (lsame diag "N")))
           (setf info 3))
          ((< n 0)
           (setf info 4))
          ((< lda (max (the f2cl-lib:integer4 1) (the f2cl-lib:integer4 n)))
           (setf info 6))
          ((= incx 0)
           (setf info 8)))
        (cond
          ((/= info 0)
           (xerbla "ZTRMV " info)
           (go end_label)))
        (if (= n 0) (go end_label))
        (setf noconj (lsame trans "T"))
        (setf nounit (lsame diag "N"))
        (cond
          ((<= incx 0)
           (setf kx
                   (f2cl-lib:int-sub 1
                                     (f2cl-lib:int-mul (f2cl-lib:int-sub n 1)
                                                       incx))))
          ((/= incx 1)
           (setf kx 1)))
        (cond
          ((lsame trans "N")
           (cond
             ((lsame uplo "U")
              (cond
                ((= incx 1)
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (cond
                       ((/= (f2cl-lib:fref x (j) ((1 *))) zero)
                        (setf temp
                                (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%))
                        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                      ((> i
                                          (f2cl-lib:int-add j
                                                            (f2cl-lib:int-sub
                                                             1)))
                                       nil)
                          (tagbody
                            (setf (f2cl-lib:fref x-%data%
                                                 (i)
                                                 ((1 *))
                                                 x-%offset%)
                                    (+
                                     (f2cl-lib:fref x-%data%
                                                    (i)
                                                    ((1 *))
                                                    x-%offset%)
                                     (* temp
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%))))
                           label10))
                        (if nounit
                            (setf (f2cl-lib:fref x-%data%
                                                 (j)
                                                 ((1 *))
                                                 x-%offset%)
                                    (*
                                     (f2cl-lib:fref x-%data%
                                                    (j)
                                                    ((1 *))
                                                    x-%offset%)
                                     (f2cl-lib:fref a-%data%
                                                    (j j)
                                                    ((1 lda) (1 *))
                                                    a-%offset%))))))
                    label20)))
                (t
                 (setf jx kx)
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (cond
                       ((/= (f2cl-lib:fref x (jx) ((1 *))) zero)
                        (setf temp
                                (f2cl-lib:fref x-%data%
                                               (jx)
                                               ((1 *))
                                               x-%offset%))
                        (setf ix kx)
                        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                      ((> i
                                          (f2cl-lib:int-add j
                                                            (f2cl-lib:int-sub
                                                             1)))
                                       nil)
                          (tagbody
                            (setf (f2cl-lib:fref x-%data%
                                                 (ix)
                                                 ((1 *))
                                                 x-%offset%)
                                    (+
                                     (f2cl-lib:fref x-%data%
                                                    (ix)
                                                    ((1 *))
                                                    x-%offset%)
                                     (* temp
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%))))
                            (setf ix (f2cl-lib:int-add ix incx))
                           label30))
                        (if nounit
                            (setf (f2cl-lib:fref x-%data%
                                                 (jx)
                                                 ((1 *))
                                                 x-%offset%)
                                    (*
                                     (f2cl-lib:fref x-%data%
                                                    (jx)
                                                    ((1 *))
                                                    x-%offset%)
                                     (f2cl-lib:fref a-%data%
                                                    (j j)
                                                    ((1 lda) (1 *))
                                                    a-%offset%))))))
                     (setf jx (f2cl-lib:int-add jx incx))
                    label40)))))
             (t
              (cond
                ((= incx 1)
                 (f2cl-lib:fdo (j n (f2cl-lib:int-add j (f2cl-lib:int-sub 1)))
                               ((> j 1) nil)
                   (tagbody
                     (cond
                       ((/= (f2cl-lib:fref x (j) ((1 *))) zero)
                        (setf temp
                                (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%))
                        (f2cl-lib:fdo (i n
                                       (f2cl-lib:int-add i
                                                         (f2cl-lib:int-sub 1)))
                                      ((> i (f2cl-lib:int-add j 1)) nil)
                          (tagbody
                            (setf (f2cl-lib:fref x-%data%
                                                 (i)
                                                 ((1 *))
                                                 x-%offset%)
                                    (+
                                     (f2cl-lib:fref x-%data%
                                                    (i)
                                                    ((1 *))
                                                    x-%offset%)
                                     (* temp
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%))))
                           label50))
                        (if nounit
                            (setf (f2cl-lib:fref x-%data%
                                                 (j)
                                                 ((1 *))
                                                 x-%offset%)
                                    (*
                                     (f2cl-lib:fref x-%data%
                                                    (j)
                                                    ((1 *))
                                                    x-%offset%)
                                     (f2cl-lib:fref a-%data%
                                                    (j j)
                                                    ((1 lda) (1 *))
                                                    a-%offset%))))))
                    label60)))
                (t
                 (setf kx
                         (f2cl-lib:int-add kx
                                           (f2cl-lib:int-mul
                                            (f2cl-lib:int-sub n 1)
                                            incx)))
                 (setf jx kx)
                 (f2cl-lib:fdo (j n (f2cl-lib:int-add j (f2cl-lib:int-sub 1)))
                               ((> j 1) nil)
                   (tagbody
                     (cond
                       ((/= (f2cl-lib:fref x (jx) ((1 *))) zero)
                        (setf temp
                                (f2cl-lib:fref x-%data%
                                               (jx)
                                               ((1 *))
                                               x-%offset%))
                        (setf ix kx)
                        (f2cl-lib:fdo (i n
                                       (f2cl-lib:int-add i
                                                         (f2cl-lib:int-sub 1)))
                                      ((> i (f2cl-lib:int-add j 1)) nil)
                          (tagbody
                            (setf (f2cl-lib:fref x-%data%
                                                 (ix)
                                                 ((1 *))
                                                 x-%offset%)
                                    (+
                                     (f2cl-lib:fref x-%data%
                                                    (ix)
                                                    ((1 *))
                                                    x-%offset%)
                                     (* temp
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%))))
                            (setf ix (f2cl-lib:int-sub ix incx))
                           label70))
                        (if nounit
                            (setf (f2cl-lib:fref x-%data%
                                                 (jx)
                                                 ((1 *))
                                                 x-%offset%)
                                    (*
                                     (f2cl-lib:fref x-%data%
                                                    (jx)
                                                    ((1 *))
                                                    x-%offset%)
                                     (f2cl-lib:fref a-%data%
                                                    (j j)
                                                    ((1 lda) (1 *))
                                                    a-%offset%))))))
                     (setf jx (f2cl-lib:int-sub jx incx))
                    label80)))))))
          (t
           (cond
             ((lsame uplo "U")
              (cond
                ((= incx 1)
                 (f2cl-lib:fdo (j n (f2cl-lib:int-add j (f2cl-lib:int-sub 1)))
                               ((> j 1) nil)
                   (tagbody
                     (setf temp
                             (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%))
                     (cond
                       (noconj
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:fref a-%data%
                                                      (j j)
                                                      ((1 lda) (1 *))
                                                      a-%offset%))))
                        (f2cl-lib:fdo (i
                                       (f2cl-lib:int-add j
                                                         (f2cl-lib:int-sub 1))
                                       (f2cl-lib:int-add i
                                                         (f2cl-lib:int-sub 1)))
                                      ((> i 1) nil)
                          (tagbody
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)
                                        (f2cl-lib:fref x-%data%
                                                       (i)
                                                       ((1 *))
                                                       x-%offset%))))
                           label90)))
                       (t
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:dconjg
                                        (f2cl-lib:fref a-%data%
                                                       (j j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)))))
                        (f2cl-lib:fdo (i
                                       (f2cl-lib:int-add j
                                                         (f2cl-lib:int-sub 1))
                                       (f2cl-lib:int-add i
                                                         (f2cl-lib:int-sub 1)))
                                      ((> i 1) nil)
                          (tagbody
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:dconjg
                                         (f2cl-lib:fref a-%data%
                                                        (i j)
                                                        ((1 lda) (1 *))
                                                        a-%offset%))
                                        (f2cl-lib:fref x-%data%
                                                       (i)
                                                       ((1 *))
                                                       x-%offset%))))
                           label100))))
                     (setf (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%)
                             temp)
                    label110)))
                (t
                 (setf jx
                         (f2cl-lib:int-add kx
                                           (f2cl-lib:int-mul
                                            (f2cl-lib:int-sub n 1)
                                            incx)))
                 (f2cl-lib:fdo (j n (f2cl-lib:int-add j (f2cl-lib:int-sub 1)))
                               ((> j 1) nil)
                   (tagbody
                     (setf temp
                             (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%))
                     (setf ix jx)
                     (cond
                       (noconj
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:fref a-%data%
                                                      (j j)
                                                      ((1 lda) (1 *))
                                                      a-%offset%))))
                        (f2cl-lib:fdo (i
                                       (f2cl-lib:int-add j
                                                         (f2cl-lib:int-sub 1))
                                       (f2cl-lib:int-add i
                                                         (f2cl-lib:int-sub 1)))
                                      ((> i 1) nil)
                          (tagbody
                            (setf ix (f2cl-lib:int-sub ix incx))
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)
                                        (f2cl-lib:fref x-%data%
                                                       (ix)
                                                       ((1 *))
                                                       x-%offset%))))
                           label120)))
                       (t
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:dconjg
                                        (f2cl-lib:fref a-%data%
                                                       (j j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)))))
                        (f2cl-lib:fdo (i
                                       (f2cl-lib:int-add j
                                                         (f2cl-lib:int-sub 1))
                                       (f2cl-lib:int-add i
                                                         (f2cl-lib:int-sub 1)))
                                      ((> i 1) nil)
                          (tagbody
                            (setf ix (f2cl-lib:int-sub ix incx))
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:dconjg
                                         (f2cl-lib:fref a-%data%
                                                        (i j)
                                                        ((1 lda) (1 *))
                                                        a-%offset%))
                                        (f2cl-lib:fref x-%data%
                                                       (ix)
                                                       ((1 *))
                                                       x-%offset%))))
                           label130))))
                     (setf (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%)
                             temp)
                     (setf jx (f2cl-lib:int-sub jx incx))
                    label140)))))
             (t
              (cond
                ((= incx 1)
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (setf temp
                             (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%))
                     (cond
                       (noconj
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:fref a-%data%
                                                      (j j)
                                                      ((1 lda) (1 *))
                                                      a-%offset%))))
                        (f2cl-lib:fdo (i (f2cl-lib:int-add j 1)
                                       (f2cl-lib:int-add i 1))
                                      ((> i n) nil)
                          (tagbody
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)
                                        (f2cl-lib:fref x-%data%
                                                       (i)
                                                       ((1 *))
                                                       x-%offset%))))
                           label150)))
                       (t
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:dconjg
                                        (f2cl-lib:fref a-%data%
                                                       (j j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)))))
                        (f2cl-lib:fdo (i (f2cl-lib:int-add j 1)
                                       (f2cl-lib:int-add i 1))
                                      ((> i n) nil)
                          (tagbody
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:dconjg
                                         (f2cl-lib:fref a-%data%
                                                        (i j)
                                                        ((1 lda) (1 *))
                                                        a-%offset%))
                                        (f2cl-lib:fref x-%data%
                                                       (i)
                                                       ((1 *))
                                                       x-%offset%))))
                           label160))))
                     (setf (f2cl-lib:fref x-%data% (j) ((1 *)) x-%offset%)
                             temp)
                    label170)))
                (t
                 (setf jx kx)
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (setf temp
                             (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%))
                     (setf ix jx)
                     (cond
                       (noconj
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:fref a-%data%
                                                      (j j)
                                                      ((1 lda) (1 *))
                                                      a-%offset%))))
                        (f2cl-lib:fdo (i (f2cl-lib:int-add j 1)
                                       (f2cl-lib:int-add i 1))
                                      ((> i n) nil)
                          (tagbody
                            (setf ix (f2cl-lib:int-add ix incx))
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:fref a-%data%
                                                       (i j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)
                                        (f2cl-lib:fref x-%data%
                                                       (ix)
                                                       ((1 *))
                                                       x-%offset%))))
                           label180)))
                       (t
                        (if nounit
                            (setf temp
                                    (* temp
                                       (f2cl-lib:dconjg
                                        (f2cl-lib:fref a-%data%
                                                       (j j)
                                                       ((1 lda) (1 *))
                                                       a-%offset%)))))
                        (f2cl-lib:fdo (i (f2cl-lib:int-add j 1)
                                       (f2cl-lib:int-add i 1))
                                      ((> i n) nil)
                          (tagbody
                            (setf ix (f2cl-lib:int-add ix incx))
                            (setf temp
                                    (+ temp
                                       (*
                                        (f2cl-lib:dconjg
                                         (f2cl-lib:fref a-%data%
                                                        (i j)
                                                        ((1 lda) (1 *))
                                                        a-%offset%))
                                        (f2cl-lib:fref x-%data%
                                                       (ix)
                                                       ((1 *))
                                                       x-%offset%))))
                           label190))))
                     (setf (f2cl-lib:fref x-%data% (jx) ((1 *)) x-%offset%)
                             temp)
                     (setf jx (f2cl-lib:int-add jx incx))
                    label200))))))))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::ztrmv fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((simple-array character (1))
                        (simple-array character (1))
                        (simple-array character (1))
                        (fortran-to-lisp::integer4)
                        (array fortran-to-lisp::complex16 (*))
                        (fortran-to-lisp::integer4)
                        (array fortran-to-lisp::complex16 (*))
                        (fortran-to-lisp::integer4))
           :return-values '(nil nil nil nil nil nil nil nil)
           :calls '(fortran-to-lisp::xerbla fortran-to-lisp::lsame))))

