#!/usr/bin/env schemesh

;; https://github.com/cosmos72/schemesh#shell-wildcards

;; # help functions

(define flatten
  (lambda (l)
    (cond
      ((null? l) l)
      ((atom? (car l)) (cons (car l) (flatten (cdr l))))
      (else (append (flatten (car l)) (flatten (cdr l)))))))

(define basename
  (lambda (path)
    (sh-run/string-rtrim-newlines {basename (values path)})))

(define basename-without-suffix
  (lambda (path suffix)
    (sh-run/string-rtrim-newlines {basename -s (values suffix) (values path)})))

(define utf8? (lambda (file) (ok? (sh-run {isutf8 --quiet (values file)}))))

(define digits-only?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((char-numeric? (car l)) (digits-only? (cdr l)))
      (else #f))))

(define string-digits-only?
  (lambda (s)
    (digits-only? (string->list s))))

(define write-string-to-file
  (lambda (string file)
    (call-with-output-file
      file
      (lambda (port)
        (display string port)))))

(define write-strings-to-file
  (lambda (strings file)
    (call-with-output-file
      file
      (lambda (port)
        (for-each
          (lambda (string) (display string port))
          strings)))))

;; # make info

(define note-dir (shell-string {$AIDAN_GIT/note}))

;; example structure:
;;
;; 	note-dir
;; 	├── a.texi
;; 	├── b
;; 	│   ├── b_image.png
;; 	│   └── b.texi
;; 	└── c.txt
;;
;; there are 3 forms of note:
;; 1. a.texi
;; 	this note form is called "texi"
;; 2. b
;; 	this note form is called "dir"
;; 3. c.txt
;; 	this note form is called "plaintext"

(define notes
  (sh-run/string-split-after-nuls
    {find (values note-dir) -mindepth 1 -maxdepth 1 -not -name ".*" -print0}))

(define diary-dir (shell-string {$AIDAN_CLOUD/archive/diary}))

;; example structure:
;;
;; 	diary-dir
;; 	└── 2009
;; 	    ├── 2009.txt
;; 	    └── 2009_turtle-and-fish.txt

(define diaries
  (sh-run/string-split-after-nuls
    {find (values diary-dir) -name "*.txt" -print0 | sort --field-separator . --key 1,1 --zero-terminated}))

(define temp-dir "/tmp/bakeinfo")

(define info-dir (shell-string {$HOME/info}))

;; ## texi2info

;; (define texi2info
;;   (lambda (texi)
;;     (sh-run
;;       {
;;         texi2any \
;;         --info \
;;         --no-split \
;;         (string-append "--output=" info-dir) \
;;         (values texi) \
;;       })))

	;; NOTE: for performance, we avoid invoking texi2any on each .texi file individually. instead, we add the .texi files to a queue and process them all at once

	(define texi-queue '())

	(define texi2info
	  (lambda (texi)
	    (set! texi-queue (cons texi texi-queue))))

;; ## dir2info

(define texi-of-dir
  (lambda (dir)
    (string-append dir "/" (basename dir) ".texi")))

(define attachments-of-dir
  (lambda (dir)
    (sh-run/string-split-after-nuls
      ;; {find (values dir) -type f -not -name "*.texi" -print0}
      {
        find (values dir) -type f \
        \( \
              -iname "*.png" \
          -or -iname "*.jpg" \
        \) \
        -print0 \
      }
)))

(define cp-attachment
  (lambda (attachment)
    (sh-run {cp (values attachment) (string-append info-dir "/" (basename attachment))})))

(define dir2info
  (lambda (dir)
    (texi2info (texi-of-dir dir))
    (for-each cp-attachment (attachments-of-dir dir))))

;; ## plaintext2info

(define texi-template-of-plaintext "\
\\input texinfo

@dircategory plaintext
@direntry
* ~a: (~a).
@end direntry

@node Top
@top ~a

@verbatiminclude ~a

@bye
")

(define plaintext2texi
  (lambda (plaintext texi)
    (let ((plaintext-basename (basename plaintext)))
      (write-string-to-file
        (format texi-template-of-plaintext plaintext-basename plaintext-basename plaintext-basename plaintext)
        texi))))

(define plaintext2info
  (lambda (plaintext)
    (let* ((plaintext-basename (basename plaintext))
           (temp-file (string-append temp-dir "/" plaintext-basename ".texi")))
      (plaintext2texi plaintext temp-file)
      (texi2info temp-file)
)))

;; ## note2info

(define note2info
  (lambda (note)
    (cond
      ((file-regular? note)
       (cond
         ((string-suffix? note ".texi")
          (texi2info note))
         ((utf8? note)
          (plaintext2info note))))
      ((file-directory? note)
       (dir2info note)))))

;; ## diary2info

(define ed-exec
  (lambda (file ed-script)
    (sh-run
      {
        $(display ed-script) | ed --script (values file) >/dev/null
      })))

(define ed-script0 "\
%g/^[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}$/#the command-list for the current g command begins here:\\
.ka\\
'a\\
/./i\\
@verbatim\\
.\\
'a\\
?.?a\\
@end verbatim\\
.\\
'a\\
.s/.*/@node &\\
@section &/
0a
@node ~a
@chapter ~a

.
w ~a
")

(define diary2texi_combined
  (lambda (diary texi)
    (let ((diary-basename (basename diary)))
      (ed-exec diary (format ed-script0 diary-basename diary-basename texi)))))

(define texi-template-of-discrete-diary "\
@node ~a
@section ~a

@verbatiminclude ~a
")

(define diary2texi_discrete
  (lambda (diary texi)
    (let ((diary-basename (basename diary)))
      (write-string-to-file
        (format texi-template-of-discrete-diary diary-basename diary-basename diary)
        texi))))

(define diary2texi
  (lambda (diary texi)
    (if (string-digits-only? (basename-without-suffix diary ".txt"))
      (diary2texi_combined diary texi)
      (diary2texi_discrete diary texi))))

(define texi-template-of-master-diary0 "\
\\input texinfo

@dircategory core
@direntry
* ~a: (~a).
@end direntry

@node Top
@top ~a

")

(define texi-template-of-master-diary1 "\
@include ~a

")

(define texi-template-of-master-diary2 "\
@bye
")

(define diaries2info
  (lambda (diaries)
    (let ((texis '())
          (texi-master-diary (string-append temp-dir "/" "diary.texi")))
      (for-each
        (lambda (diary)
          (let* ((diary-basename (basename diary))
                 (temp-file (string-append temp-dir "/" diary-basename ".texi")))
            (if (string-digits-only? (basename-without-suffix diary ".txt"))
              (begin
                (diary2texi_combined diary temp-file)
                (set! texis (cons (list temp-file) texis)))
              (begin
                (diary2texi_discrete diary temp-file)
                (set! texis (cons (append (car texis) (list temp-file)) (cdr texis)))))))
        diaries)
      (set! texis (flatten texis))
      (write-strings-to-file
        (append
          (list
            (format texi-template-of-master-diary0 "diary" "diary" "diary"))
          (map
            (lambda (texi) (format texi-template-of-master-diary1 texi))
            texis)
          (list
            texi-template-of-master-diary2))
        texi-master-diary)
      (texi2info texi-master-diary)
)))

;; ## make info (execution)

(sh-run {mkdir -p (values temp-dir)})

(sh-run {mkdir -p (values info-dir)})

(sh-run {rm -rf (wildcard #f (string-append temp-dir "/") '*)})
;; https://github.com/cosmos72/schemesh/issues/54

(for-each note2info notes)

(diaries2info diaries)

	;; NOTE: for performance, we avoid invoking texi2any on each .texi file individually. instead, we add the .texi files to a queue and process them all at once

	(sh-run
	  {
	    texi2any \
	    --set-customization-variable paragraphindent=asis \
	    --set-customization-variable INFO_SPECIAL_CHARS_WARNING=0 \
	    --info \
	    --no-split \
	    (string-append "--output=" info-dir) \
	    (values texi-queue) \
	  })
	    ;; --set-customization-variable INFO_MATH_IMAGES=1 \

;; # install info

(define dirfile (shell-string {$HOME/info/dir.info}))

(define infos-without-dirfile
  (sh-run/string-split-after-nuls
    {find (values info-dir) -type f -name "*.info" -not -name "dir.info" -print0}))

(define add-info-entry-to-dirfile
  (lambda (info)
    (sh-run
      {
        install-info \
        (string-append "--dir-file=" dirfile) \
        (string-append "--info-file=" info) \
      })))

;; ## install info (execution)

(for-each add-info-entry-to-dirfile infos-without-dirfile)
