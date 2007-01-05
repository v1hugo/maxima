;;; Compiled by f2cl version 2.0 beta Date: 2006/12/21 03:42:11 
;;; Using Lisp CMU Common Lisp CVS Head 2006-12-02 00:15:46 (19D)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "BLAS")


(let* ((one (f2cl-lib:cmplx 1.0 0.0)) (zero (f2cl-lib:cmplx 0.0 0.0)))
  (declare (type (f2cl-lib:complex16) one) (type (f2cl-lib:complex16) zero))
  (defun ztrmm (side uplo transa diag m n alpha a lda b ldb$)
    (declare (type (array f2cl-lib:complex16 (*)) b a)
             (type (f2cl-lib:complex16) alpha)
             (type (f2cl-lib:integer4) ldb$ lda n m)
             (type (simple-array character (*)) diag transa uplo side))
    (f2cl-lib:with-multi-array-data
        ((side character side-%data% side-%offset%)
         (uplo character uplo-%data% uplo-%offset%)
         (transa character transa-%data% transa-%offset%)
         (diag character diag-%data% diag-%offset%)
         (a f2cl-lib:complex16 a-%data% a-%offset%)
         (b f2cl-lib:complex16 b-%data% b-%offset%))
      (prog ((temp #C(0.0 0.0)) (i 0) (info 0) (j 0) (k 0) (nrowa 0)
             (lside nil) (noconj nil) (nounit nil) (upper nil))
        (declare (type (f2cl-lib:complex16) temp)
                 (type (f2cl-lib:integer4) i info j k nrowa)
                 (type f2cl-lib:logical lside noconj nounit upper))
        (setf lside (lsame side "L"))
        (cond
          (lside
           (setf nrowa m))
          (t
           (setf nrowa n)))
        (setf noconj (lsame transa "T"))
        (setf nounit (lsame diag "N"))
        (setf upper (lsame uplo "U"))
        (setf info 0)
        (cond
          ((and (not lside) (not (lsame side "R")))
           (setf info 1))
          ((and (not upper) (not (lsame uplo "L")))
           (setf info 2))
          ((and (not (lsame transa "N"))
                (not (lsame transa "T"))
                (not (lsame transa "C")))
           (setf info 3))
          ((and (not (lsame diag "U")) (not (lsame diag "N")))
           (setf info 4))
          ((< m 0)
           (setf info 5))
          ((< n 0)
           (setf info 6))
          ((< lda (max (the f2cl-lib:integer4 1) (the f2cl-lib:integer4 nrowa)))
           (setf info 9))
          ((< ldb$ (max (the f2cl-lib:integer4 1) (the f2cl-lib:integer4 m)))
           (setf info 11)))
        (cond
          ((/= info 0)
           (xerbla "ZTRMM " info)
           (go end_label)))
        (if (= n 0) (go end_label))
        (cond
          ((= alpha zero)
           (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                         ((> j n) nil)
             (tagbody
               (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                             ((> i m) nil)
                 (tagbody
                   (setf (f2cl-lib:fref b-%data%
                                        (i j)
                                        ((1 ldb$) (1 *))
                                        b-%offset%)
                           zero)
                  label10))
              label20))
           (go end_label)))
        (cond
          (lside
           (cond
             ((lsame transa "N")
              (cond
                (upper
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                                   ((> k m) nil)
                       (tagbody
                         (cond
                           ((/= (f2cl-lib:fref b (k j) ((1 ldb$) (1 *))) zero)
                            (setf temp
                                    (* alpha
                                       (f2cl-lib:fref b-%data%
                                                      (k j)
                                                      ((1 ldb$) (1 *))
                                                      b-%offset%)))
                            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                          ((> i
                                              (f2cl-lib:int-add k
                                                                (f2cl-lib:int-sub
                                                                 1)))
                                           nil)
                              (tagbody
                                (setf (f2cl-lib:fref b-%data%
                                                     (i j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (+
                                         (f2cl-lib:fref b-%data%
                                                        (i j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (* temp
                                            (f2cl-lib:fref a-%data%
                                                           (i k)
                                                           ((1 lda) (1 *))
                                                           a-%offset%))))
                               label30))
                            (if nounit
                                (setf temp
                                        (* temp
                                           (f2cl-lib:fref a-%data%
                                                          (k k)
                                                          ((1 lda) (1 *))
                                                          a-%offset%))))
                            (setf (f2cl-lib:fref b-%data%
                                                 (k j)
                                                 ((1 ldb$) (1 *))
                                                 b-%offset%)
                                    temp)))
                        label40))
                    label50)))
                (t
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (f2cl-lib:fdo (k m
                                    (f2cl-lib:int-add k (f2cl-lib:int-sub 1)))
                                   ((> k 1) nil)
                       (tagbody
                         (cond
                           ((/= (f2cl-lib:fref b (k j) ((1 ldb$) (1 *))) zero)
                            (setf temp
                                    (* alpha
                                       (f2cl-lib:fref b-%data%
                                                      (k j)
                                                      ((1 ldb$) (1 *))
                                                      b-%offset%)))
                            (setf (f2cl-lib:fref b-%data%
                                                 (k j)
                                                 ((1 ldb$) (1 *))
                                                 b-%offset%)
                                    temp)
                            (if nounit
                                (setf (f2cl-lib:fref b-%data%
                                                     (k j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (*
                                         (f2cl-lib:fref b-%data%
                                                        (k j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (f2cl-lib:fref a-%data%
                                                        (k k)
                                                        ((1 lda) (1 *))
                                                        a-%offset%))))
                            (f2cl-lib:fdo (i (f2cl-lib:int-add k 1)
                                           (f2cl-lib:int-add i 1))
                                          ((> i m) nil)
                              (tagbody
                                (setf (f2cl-lib:fref b-%data%
                                                     (i j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (+
                                         (f2cl-lib:fref b-%data%
                                                        (i j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (* temp
                                            (f2cl-lib:fref a-%data%
                                                           (i k)
                                                           ((1 lda) (1 *))
                                                           a-%offset%))))
                               label60))))
                        label70))
                    label80)))))
             (t
              (cond
                (upper
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (f2cl-lib:fdo (i m
                                    (f2cl-lib:int-add i (f2cl-lib:int-sub 1)))
                                   ((> i 1) nil)
                       (tagbody
                         (setf temp
                                 (f2cl-lib:fref b-%data%
                                                (i j)
                                                ((1 ldb$) (1 *))
                                                b-%offset%))
                         (cond
                           (noconj
                            (if nounit
                                (setf temp
                                        (* temp
                                           (f2cl-lib:fref a-%data%
                                                          (i i)
                                                          ((1 lda) (1 *))
                                                          a-%offset%))))
                            (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                                          ((> k
                                              (f2cl-lib:int-add i
                                                                (f2cl-lib:int-sub
                                                                 1)))
                                           nil)
                              (tagbody
                                (setf temp
                                        (+ temp
                                           (*
                                            (f2cl-lib:fref a-%data%
                                                           (k i)
                                                           ((1 lda) (1 *))
                                                           a-%offset%)
                                            (f2cl-lib:fref b-%data%
                                                           (k j)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label90)))
                           (t
                            (if nounit
                                (setf temp
                                        (* temp
                                           (f2cl-lib:dconjg
                                            (f2cl-lib:fref a-%data%
                                                           (i i)
                                                           ((1 lda) (1 *))
                                                           a-%offset%)))))
                            (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                                          ((> k
                                              (f2cl-lib:int-add i
                                                                (f2cl-lib:int-sub
                                                                 1)))
                                           nil)
                              (tagbody
                                (setf temp
                                        (+ temp
                                           (*
                                            (f2cl-lib:dconjg
                                             (f2cl-lib:fref a-%data%
                                                            (k i)
                                                            ((1 lda) (1 *))
                                                            a-%offset%))
                                            (f2cl-lib:fref b-%data%
                                                           (k j)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label100))))
                         (setf (f2cl-lib:fref b-%data%
                                              (i j)
                                              ((1 ldb$) (1 *))
                                              b-%offset%)
                                 (* alpha temp))
                        label110))
                    label120)))
                (t
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                   ((> i m) nil)
                       (tagbody
                         (setf temp
                                 (f2cl-lib:fref b-%data%
                                                (i j)
                                                ((1 ldb$) (1 *))
                                                b-%offset%))
                         (cond
                           (noconj
                            (if nounit
                                (setf temp
                                        (* temp
                                           (f2cl-lib:fref a-%data%
                                                          (i i)
                                                          ((1 lda) (1 *))
                                                          a-%offset%))))
                            (f2cl-lib:fdo (k (f2cl-lib:int-add i 1)
                                           (f2cl-lib:int-add k 1))
                                          ((> k m) nil)
                              (tagbody
                                (setf temp
                                        (+ temp
                                           (*
                                            (f2cl-lib:fref a-%data%
                                                           (k i)
                                                           ((1 lda) (1 *))
                                                           a-%offset%)
                                            (f2cl-lib:fref b-%data%
                                                           (k j)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label130)))
                           (t
                            (if nounit
                                (setf temp
                                        (* temp
                                           (f2cl-lib:dconjg
                                            (f2cl-lib:fref a-%data%
                                                           (i i)
                                                           ((1 lda) (1 *))
                                                           a-%offset%)))))
                            (f2cl-lib:fdo (k (f2cl-lib:int-add i 1)
                                           (f2cl-lib:int-add k 1))
                                          ((> k m) nil)
                              (tagbody
                                (setf temp
                                        (+ temp
                                           (*
                                            (f2cl-lib:dconjg
                                             (f2cl-lib:fref a-%data%
                                                            (k i)
                                                            ((1 lda) (1 *))
                                                            a-%offset%))
                                            (f2cl-lib:fref b-%data%
                                                           (k j)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label140))))
                         (setf (f2cl-lib:fref b-%data%
                                              (i j)
                                              ((1 ldb$) (1 *))
                                              b-%offset%)
                                 (* alpha temp))
                        label150))
                    label160)))))))
          (t
           (cond
             ((lsame transa "N")
              (cond
                (upper
                 (f2cl-lib:fdo (j n (f2cl-lib:int-add j (f2cl-lib:int-sub 1)))
                               ((> j 1) nil)
                   (tagbody
                     (setf temp alpha)
                     (if nounit
                         (setf temp
                                 (* temp
                                    (f2cl-lib:fref a-%data%
                                                   (j j)
                                                   ((1 lda) (1 *))
                                                   a-%offset%))))
                     (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                   ((> i m) nil)
                       (tagbody
                         (setf (f2cl-lib:fref b-%data%
                                              (i j)
                                              ((1 ldb$) (1 *))
                                              b-%offset%)
                                 (* temp
                                    (f2cl-lib:fref b-%data%
                                                   (i j)
                                                   ((1 ldb$) (1 *))
                                                   b-%offset%)))
                        label170))
                     (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                                   ((> k
                                       (f2cl-lib:int-add j
                                                         (f2cl-lib:int-sub 1)))
                                    nil)
                       (tagbody
                         (cond
                           ((/= (f2cl-lib:fref a (k j) ((1 lda) (1 *))) zero)
                            (setf temp
                                    (* alpha
                                       (f2cl-lib:fref a-%data%
                                                      (k j)
                                                      ((1 lda) (1 *))
                                                      a-%offset%)))
                            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                          ((> i m) nil)
                              (tagbody
                                (setf (f2cl-lib:fref b-%data%
                                                     (i j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (+
                                         (f2cl-lib:fref b-%data%
                                                        (i j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (* temp
                                            (f2cl-lib:fref b-%data%
                                                           (i k)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label180))))
                        label190))
                    label200)))
                (t
                 (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                               ((> j n) nil)
                   (tagbody
                     (setf temp alpha)
                     (if nounit
                         (setf temp
                                 (* temp
                                    (f2cl-lib:fref a-%data%
                                                   (j j)
                                                   ((1 lda) (1 *))
                                                   a-%offset%))))
                     (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                   ((> i m) nil)
                       (tagbody
                         (setf (f2cl-lib:fref b-%data%
                                              (i j)
                                              ((1 ldb$) (1 *))
                                              b-%offset%)
                                 (* temp
                                    (f2cl-lib:fref b-%data%
                                                   (i j)
                                                   ((1 ldb$) (1 *))
                                                   b-%offset%)))
                        label210))
                     (f2cl-lib:fdo (k (f2cl-lib:int-add j 1)
                                    (f2cl-lib:int-add k 1))
                                   ((> k n) nil)
                       (tagbody
                         (cond
                           ((/= (f2cl-lib:fref a (k j) ((1 lda) (1 *))) zero)
                            (setf temp
                                    (* alpha
                                       (f2cl-lib:fref a-%data%
                                                      (k j)
                                                      ((1 lda) (1 *))
                                                      a-%offset%)))
                            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                          ((> i m) nil)
                              (tagbody
                                (setf (f2cl-lib:fref b-%data%
                                                     (i j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (+
                                         (f2cl-lib:fref b-%data%
                                                        (i j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (* temp
                                            (f2cl-lib:fref b-%data%
                                                           (i k)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label220))))
                        label230))
                    label240)))))
             (t
              (cond
                (upper
                 (f2cl-lib:fdo (k 1 (f2cl-lib:int-add k 1))
                               ((> k n) nil)
                   (tagbody
                     (f2cl-lib:fdo (j 1 (f2cl-lib:int-add j 1))
                                   ((> j
                                       (f2cl-lib:int-add k
                                                         (f2cl-lib:int-sub 1)))
                                    nil)
                       (tagbody
                         (cond
                           ((/= (f2cl-lib:fref a (j k) ((1 lda) (1 *))) zero)
                            (cond
                              (noconj
                               (setf temp
                                       (* alpha
                                          (f2cl-lib:fref a-%data%
                                                         (j k)
                                                         ((1 lda) (1 *))
                                                         a-%offset%))))
                              (t
                               (setf temp
                                       (* alpha
                                          (f2cl-lib:dconjg
                                           (f2cl-lib:fref a-%data%
                                                          (j k)
                                                          ((1 lda) (1 *))
                                                          a-%offset%))))))
                            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                          ((> i m) nil)
                              (tagbody
                                (setf (f2cl-lib:fref b-%data%
                                                     (i j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (+
                                         (f2cl-lib:fref b-%data%
                                                        (i j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (* temp
                                            (f2cl-lib:fref b-%data%
                                                           (i k)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label250))))
                        label260))
                     (setf temp alpha)
                     (cond
                       (nounit
                        (cond
                          (noconj
                           (setf temp
                                   (* temp
                                      (f2cl-lib:fref a-%data%
                                                     (k k)
                                                     ((1 lda) (1 *))
                                                     a-%offset%))))
                          (t
                           (setf temp
                                   (* temp
                                      (f2cl-lib:dconjg
                                       (f2cl-lib:fref a-%data%
                                                      (k k)
                                                      ((1 lda) (1 *))
                                                      a-%offset%))))))))
                     (cond
                       ((/= temp one)
                        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                      ((> i m) nil)
                          (tagbody
                            (setf (f2cl-lib:fref b-%data%
                                                 (i k)
                                                 ((1 ldb$) (1 *))
                                                 b-%offset%)
                                    (* temp
                                       (f2cl-lib:fref b-%data%
                                                      (i k)
                                                      ((1 ldb$) (1 *))
                                                      b-%offset%)))
                           label270))))
                    label280)))
                (t
                 (f2cl-lib:fdo (k n (f2cl-lib:int-add k (f2cl-lib:int-sub 1)))
                               ((> k 1) nil)
                   (tagbody
                     (f2cl-lib:fdo (j (f2cl-lib:int-add k 1)
                                    (f2cl-lib:int-add j 1))
                                   ((> j n) nil)
                       (tagbody
                         (cond
                           ((/= (f2cl-lib:fref a (j k) ((1 lda) (1 *))) zero)
                            (cond
                              (noconj
                               (setf temp
                                       (* alpha
                                          (f2cl-lib:fref a-%data%
                                                         (j k)
                                                         ((1 lda) (1 *))
                                                         a-%offset%))))
                              (t
                               (setf temp
                                       (* alpha
                                          (f2cl-lib:dconjg
                                           (f2cl-lib:fref a-%data%
                                                          (j k)
                                                          ((1 lda) (1 *))
                                                          a-%offset%))))))
                            (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                          ((> i m) nil)
                              (tagbody
                                (setf (f2cl-lib:fref b-%data%
                                                     (i j)
                                                     ((1 ldb$) (1 *))
                                                     b-%offset%)
                                        (+
                                         (f2cl-lib:fref b-%data%
                                                        (i j)
                                                        ((1 ldb$) (1 *))
                                                        b-%offset%)
                                         (* temp
                                            (f2cl-lib:fref b-%data%
                                                           (i k)
                                                           ((1 ldb$) (1 *))
                                                           b-%offset%))))
                               label290))))
                        label300))
                     (setf temp alpha)
                     (cond
                       (nounit
                        (cond
                          (noconj
                           (setf temp
                                   (* temp
                                      (f2cl-lib:fref a-%data%
                                                     (k k)
                                                     ((1 lda) (1 *))
                                                     a-%offset%))))
                          (t
                           (setf temp
                                   (* temp
                                      (f2cl-lib:dconjg
                                       (f2cl-lib:fref a-%data%
                                                      (k k)
                                                      ((1 lda) (1 *))
                                                      a-%offset%))))))))
                     (cond
                       ((/= temp one)
                        (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                                      ((> i m) nil)
                          (tagbody
                            (setf (f2cl-lib:fref b-%data%
                                                 (i k)
                                                 ((1 ldb$) (1 *))
                                                 b-%offset%)
                                    (* temp
                                       (f2cl-lib:fref b-%data%
                                                      (i k)
                                                      ((1 ldb$) (1 *))
                                                      b-%offset%)))
                           label310))))
                    label320))))))))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::ztrmm fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((simple-array character (1))
                        (simple-array character (1))
                        (simple-array character (1))
                        (simple-array character (1))
                        (fortran-to-lisp::integer4) (fortran-to-lisp::integer4)
                        (fortran-to-lisp::complex16)
                        (array fortran-to-lisp::complex16 (*))
                        (fortran-to-lisp::integer4)
                        (array fortran-to-lisp::complex16 (*))
                        (fortran-to-lisp::integer4))
           :return-values '(nil nil nil nil nil nil nil nil nil nil nil)
           :calls '(fortran-to-lisp::xerbla fortran-to-lisp::lsame))))

