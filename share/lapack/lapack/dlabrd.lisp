;;; Compiled by f2cl version 2.0 beta Date: 2006/12/21 03:42:11 
;;; Using Lisp CMU Common Lisp CVS Head 2006-12-02 00:15:46 (19D)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package "LAPACK")


(let* ((zero 0.0) (one 1.0))
  (declare (type (double-float 0.0 0.0) zero)
           (type (double-float 1.0 1.0) one))
  (defun dlabrd (m n nb a lda d e tauq taup x ldx y ldy)
    (declare (type (array double-float (*)) y x taup tauq e d a)
             (type (f2cl-lib:integer4) ldy ldx lda nb n m))
    (f2cl-lib:with-multi-array-data
        ((a double-float a-%data% a-%offset%)
         (d double-float d-%data% d-%offset%)
         (e double-float e-%data% e-%offset%)
         (tauq double-float tauq-%data% tauq-%offset%)
         (taup double-float taup-%data% taup-%offset%)
         (x double-float x-%data% x-%offset%)
         (y double-float y-%data% y-%offset%))
      (prog ((i 0))
        (declare (type (f2cl-lib:integer4) i))
        (if (or (<= m 0) (<= n 0)) (go end_label))
        (cond
          ((>= m n)
           (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                         ((> i nb) nil)
             (tagbody
               (dgemv "No transpose"
                (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                (f2cl-lib:int-sub i 1) (- one)
                (f2cl-lib:array-slice a double-float (i 1) ((1 lda) (1 *))) lda
                (f2cl-lib:array-slice y double-float (i 1) ((1 ldy) (1 *))) ldy
                one (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                1)
               (dgemv "No transpose"
                (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                (f2cl-lib:int-sub i 1) (- one)
                (f2cl-lib:array-slice x double-float (i 1) ((1 ldx) (1 *))) ldx
                (f2cl-lib:array-slice a double-float (1 i) ((1 lda) (1 *))) 1
                one (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                1)
               (multiple-value-bind (var-0 var-1 var-2 var-3 var-4)
                   (dlarfg (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                    (f2cl-lib:fref a-%data% (i i) ((1 lda) (1 *)) a-%offset%)
                    (f2cl-lib:array-slice a
                                          double-float
                                          ((min (f2cl-lib:int-add i 1) m) i)
                                          ((1 lda) (1 *)))
                    1 (f2cl-lib:fref tauq-%data% (i) ((1 *)) tauq-%offset%))
                 (declare (ignore var-0 var-2 var-3))
                 (setf (f2cl-lib:fref a-%data%
                                      (i i)
                                      ((1 lda) (1 *))
                                      a-%offset%)
                         var-1)
                 (setf (f2cl-lib:fref tauq-%data% (i) ((1 *)) tauq-%offset%)
                         var-4))
               (setf (f2cl-lib:fref d-%data% (i) ((1 *)) d-%offset%)
                       (f2cl-lib:fref a-%data%
                                      (i i)
                                      ((1 lda) (1 *))
                                      a-%offset%))
               (cond
                 ((< i n)
                  (setf (f2cl-lib:fref a-%data%
                                       (i i)
                                       ((1 lda) (1 *))
                                       a-%offset%)
                          one)
                  (dgemv "Transpose"
                   (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                   (f2cl-lib:int-sub n i) one
                   (f2cl-lib:array-slice a
                                         double-float
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                   1 zero
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dgemv "Transpose"
                   (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                   (f2cl-lib:int-sub i 1) one
                   (f2cl-lib:array-slice a double-float (i 1) ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                   1 zero
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub n i)
                   (f2cl-lib:int-sub i 1) (- one)
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldy) (1 *)))
                   ldy
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1 one
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dgemv "Transpose"
                   (f2cl-lib:int-add (f2cl-lib:int-sub m i) 1)
                   (f2cl-lib:int-sub i 1) one
                   (f2cl-lib:array-slice x double-float (i 1) ((1 ldx) (1 *)))
                   ldx
                   (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                   1 zero
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1)
                  (dgemv "Transpose" (f2cl-lib:int-sub i 1)
                   (f2cl-lib:int-sub n i) (- one)
                   (f2cl-lib:array-slice a
                                         double-float
                                         (1 (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1 one
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dscal (f2cl-lib:int-sub n i)
                   (f2cl-lib:fref tauq-%data% (i) ((1 *)) tauq-%offset%)
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub n i) i (- one)
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldy) (1 *)))
                   ldy
                   (f2cl-lib:array-slice a double-float (i 1) ((1 lda) (1 *)))
                   lda one
                   (f2cl-lib:array-slice a
                                         double-float
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda)
                  (dgemv "Transpose" (f2cl-lib:int-sub i 1)
                   (f2cl-lib:int-sub n i) (- one)
                   (f2cl-lib:array-slice a
                                         double-float
                                         (1 (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice x double-float (i 1) ((1 ldx) (1 *)))
                   ldx one
                   (f2cl-lib:array-slice a
                                         double-float
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda)
                  (multiple-value-bind (var-0 var-1 var-2 var-3 var-4)
                      (dlarfg (f2cl-lib:int-sub n i)
                       (f2cl-lib:fref a-%data%
                                      (i (f2cl-lib:int-add i 1))
                                      ((1 lda) (1 *))
                                      a-%offset%)
                       (f2cl-lib:array-slice a
                                             double-float
                                             (i
                                              (min
                                               (the f2cl-lib:integer4
                                                    (f2cl-lib:int-add i 2))
                                               (the f2cl-lib:integer4 n)))
                                             ((1 lda) (1 *)))
                       lda
                       (f2cl-lib:fref taup-%data% (i) ((1 *)) taup-%offset%))
                    (declare (ignore var-0 var-2 var-3))
                    (setf (f2cl-lib:fref a-%data%
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *))
                                         a-%offset%)
                            var-1)
                    (setf (f2cl-lib:fref taup-%data% (i) ((1 *)) taup-%offset%)
                            var-4))
                  (setf (f2cl-lib:fref e-%data% (i) ((1 *)) e-%offset%)
                          (f2cl-lib:fref a-%data%
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *))
                                         a-%offset%))
                  (setf (f2cl-lib:fref a-%data%
                                       (i (f2cl-lib:int-add i 1))
                                       ((1 lda) (1 *))
                                       a-%offset%)
                          one)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub n i) one
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a
                                         double-float
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda zero
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dgemv "Transpose" (f2cl-lib:int-sub n i) i one
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldy) (1 *)))
                   ldy
                   (f2cl-lib:array-slice a
                                         double-float
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda zero
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i) i (- one)
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1 one
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub i 1)
                   (f2cl-lib:int-sub n i) one
                   (f2cl-lib:array-slice a
                                         double-float
                                         (1 (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a
                                         double-float
                                         (i (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda zero
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub i 1) (- one)
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldx) (1 *)))
                   ldx
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1 one
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dscal (f2cl-lib:int-sub m i)
                   (f2cl-lib:fref taup-%data% (i) ((1 *)) taup-%offset%)
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)))
              label10)))
          (t
           (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                         ((> i nb) nil)
             (tagbody
               (dgemv "No transpose"
                (f2cl-lib:int-add (f2cl-lib:int-sub n i) 1)
                (f2cl-lib:int-sub i 1) (- one)
                (f2cl-lib:array-slice y double-float (i 1) ((1 ldy) (1 *))) ldy
                (f2cl-lib:array-slice a double-float (i 1) ((1 lda) (1 *))) lda
                one (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                lda)
               (dgemv "Transpose" (f2cl-lib:int-sub i 1)
                (f2cl-lib:int-add (f2cl-lib:int-sub n i) 1) (- one)
                (f2cl-lib:array-slice a double-float (1 i) ((1 lda) (1 *))) lda
                (f2cl-lib:array-slice x double-float (i 1) ((1 ldx) (1 *))) ldx
                one (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                lda)
               (multiple-value-bind (var-0 var-1 var-2 var-3 var-4)
                   (dlarfg (f2cl-lib:int-add (f2cl-lib:int-sub n i) 1)
                    (f2cl-lib:fref a-%data% (i i) ((1 lda) (1 *)) a-%offset%)
                    (f2cl-lib:array-slice a
                                          double-float
                                          (i
                                           (min
                                            (the f2cl-lib:integer4
                                                 (f2cl-lib:int-add i 1))
                                            (the f2cl-lib:integer4 n)))
                                          ((1 lda) (1 *)))
                    lda (f2cl-lib:fref taup-%data% (i) ((1 *)) taup-%offset%))
                 (declare (ignore var-0 var-2 var-3))
                 (setf (f2cl-lib:fref a-%data%
                                      (i i)
                                      ((1 lda) (1 *))
                                      a-%offset%)
                         var-1)
                 (setf (f2cl-lib:fref taup-%data% (i) ((1 *)) taup-%offset%)
                         var-4))
               (setf (f2cl-lib:fref d-%data% (i) ((1 *)) d-%offset%)
                       (f2cl-lib:fref a-%data%
                                      (i i)
                                      ((1 lda) (1 *))
                                      a-%offset%))
               (cond
                 ((< i m)
                  (setf (f2cl-lib:fref a-%data%
                                       (i i)
                                       ((1 lda) (1 *))
                                       a-%offset%)
                          one)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-add (f2cl-lib:int-sub n i) 1) one
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) i)
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                   lda zero
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dgemv "Transpose"
                   (f2cl-lib:int-add (f2cl-lib:int-sub n i) 1)
                   (f2cl-lib:int-sub i 1) one
                   (f2cl-lib:array-slice y double-float (i 1) ((1 ldy) (1 *)))
                   ldy
                   (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                   lda zero
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub i 1) (- one)
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1 one
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub i 1)
                   (f2cl-lib:int-add (f2cl-lib:int-sub n i) 1) one
                   (f2cl-lib:array-slice a double-float (1 i) ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a double-float (i i) ((1 lda) (1 *)))
                   lda zero
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub i 1) (- one)
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldx) (1 *)))
                   ldx
                   (f2cl-lib:array-slice x double-float (1 i) ((1 ldx) (1 *)))
                   1 one
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dscal (f2cl-lib:int-sub m i)
                   (f2cl-lib:fref taup-%data% (i) ((1 *)) taup-%offset%)
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldx) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub i 1) (- one)
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice y double-float (i 1) ((1 ldy) (1 *)))
                   ldy one
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) i)
                                         ((1 lda) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub m i) i (- one)
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldx) (1 *)))
                   ldx
                   (f2cl-lib:array-slice a double-float (1 i) ((1 lda) (1 *)))
                   1 one
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) i)
                                         ((1 lda) (1 *)))
                   1)
                  (multiple-value-bind (var-0 var-1 var-2 var-3 var-4)
                      (dlarfg (f2cl-lib:int-sub m i)
                       (f2cl-lib:fref a-%data%
                                      ((f2cl-lib:int-add i 1) i)
                                      ((1 lda) (1 *))
                                      a-%offset%)
                       (f2cl-lib:array-slice a
                                             double-float
                                             ((min (f2cl-lib:int-add i 2) m) i)
                                             ((1 lda) (1 *)))
                       1 (f2cl-lib:fref tauq-%data% (i) ((1 *)) tauq-%offset%))
                    (declare (ignore var-0 var-2 var-3))
                    (setf (f2cl-lib:fref a-%data%
                                         ((f2cl-lib:int-add i 1) i)
                                         ((1 lda) (1 *))
                                         a-%offset%)
                            var-1)
                    (setf (f2cl-lib:fref tauq-%data% (i) ((1 *)) tauq-%offset%)
                            var-4))
                  (setf (f2cl-lib:fref e-%data% (i) ((1 *)) e-%offset%)
                          (f2cl-lib:fref a-%data%
                                         ((f2cl-lib:int-add i 1) i)
                                         ((1 lda) (1 *))
                                         a-%offset%))
                  (setf (f2cl-lib:fref a-%data%
                                       ((f2cl-lib:int-add i 1) i)
                                       ((1 lda) (1 *))
                                       a-%offset%)
                          one)
                  (dgemv "Transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub n i) one
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) i)
                                         ((1 lda) (1 *)))
                   1 zero
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dgemv "Transpose" (f2cl-lib:int-sub m i)
                   (f2cl-lib:int-sub i 1) one
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) i)
                                         ((1 lda) (1 *)))
                   1 zero
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1)
                  (dgemv "No transpose" (f2cl-lib:int-sub n i)
                   (f2cl-lib:int-sub i 1) (- one)
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldy) (1 *)))
                   ldy
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1 one
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dgemv "Transpose" (f2cl-lib:int-sub m i) i one
                   (f2cl-lib:array-slice x
                                         double-float
                                         ((+ i 1) 1)
                                         ((1 ldx) (1 *)))
                   ldx
                   (f2cl-lib:array-slice a
                                         double-float
                                         ((+ i 1) i)
                                         ((1 lda) (1 *)))
                   1 zero
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1)
                  (dgemv "Transpose" i (f2cl-lib:int-sub n i) (- one)
                   (f2cl-lib:array-slice a
                                         double-float
                                         (1 (f2cl-lib:int-add i 1))
                                         ((1 lda) (1 *)))
                   lda
                   (f2cl-lib:array-slice y double-float (1 i) ((1 ldy) (1 *)))
                   1 one
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)
                  (dscal (f2cl-lib:int-sub n i)
                   (f2cl-lib:fref tauq-%data% (i) ((1 *)) tauq-%offset%)
                   (f2cl-lib:array-slice y
                                         double-float
                                         ((+ i 1) i)
                                         ((1 ldy) (1 *)))
                   1)))
              label20))))
        (go end_label)
       end_label
        (return
         (values nil nil nil nil nil nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::dlabrd
                 fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((fortran-to-lisp::integer4) (fortran-to-lisp::integer4)
                        (fortran-to-lisp::integer4) (array double-float (*))
                        (fortran-to-lisp::integer4) (array double-float (*))
                        (array double-float (*)) (array double-float (*))
                        (array double-float (*)) (array double-float (*))
                        (fortran-to-lisp::integer4) (array double-float (*))
                        (fortran-to-lisp::integer4))
           :return-values '(nil nil nil nil nil nil nil nil nil nil nil nil
                            nil)
           :calls '(fortran-to-lisp::dscal fortran-to-lisp::dlarfg
                    fortran-to-lisp::dgemv))))

