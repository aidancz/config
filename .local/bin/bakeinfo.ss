#!/usr/bin/env schemesh

;; https://github.com/cosmos72/schemesh#shell-wildcards

;; # help functions

(define basename
  (lambda (path)
    (sh-run/string-rtrim-newlines {basename (values path)})))

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

;; # make info

(define note-dir (shell-string {$AIDAN_GIT/note}))
(define diary-dir (shell-string {$AIDAN_CLOUD/archive/diary}))
(define note-path (list note-dir diary-dir))

(define notes
  (sh-run/string-split-after-nuls
    {find (values note-path) -mindepth 1 -maxdepth 1 -not -name ".*" -print0}))

;; example structure:
;; 	note-path
;; 	├── a.texi
;; 	├── b
;; 	│   ├── b_image.png
;; 	│   └── b.texi
;; 	├── c.txt
;; 	└── 2009
;; 	    ├── 2009.txt
;; 	    └── 2009_turtle-and-fish.txt
;; there are 4 notes:
;; 1. a.texi
;; 	this note form is called "texi"
;; 2. b
;; 	this note form is called "dir"
;; 3. c.txt
;; 	this note form is called "plaintext"
;; 4. 2009
;; 	this note form is called "diary"

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

(define dir2info
  (lambda (dir)
    (texi2info (string-append dir "/" (basename dir) ".texi"))
    (for-each
      (lambda (attachment)
        (sh-run {cp (values attachment) (string-append info-dir "/" (basename attachment))}))
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
))))

;; ## plaintext2info

(define plaintext2info
  (lambda (plaintext)
    (let* ((plaintext-basename (basename plaintext))
           (temp-file (string-append temp-dir "/" plaintext-basename ".texi"))
           (texi-generated-from-plaintext (format "\
\\input texinfo

@dircategory plaintext
@direntry
* ~a: (~a).
@end direntry

@node Top
@top ~a

@verbatiminclude ~a

@bye
" plaintext-basename plaintext-basename plaintext-basename plaintext)))
      (call-with-output-file
        temp-file
        (lambda (port)
          (display texi-generated-from-plaintext port)))
      (texi2info temp-file)
)))

;; ## diary2info

(define diary2texi
  (lambda (diary-file texi-file)
    (let* ((diary-file-basename (basename diary-file))
           (ed-script (format "\
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
@chapter &/
1i
\\input texinfo

@dircategory diary
@direntry
* ~a: (~a).
@end direntry

@node Top
@top ~a

.
$a

@bye
.
w ~a
" diary-file-basename diary-file-basename diary-file-basename texi-file)))
      (sh-run
        {
          $(display ed-script) | ed --script (values diary-file) >/dev/null
        }))))

(define texi-prepend-chapter
  (lambda (texi-file chapter-file)
    (let* ((chapter-file-basename (basename chapter-file))
           (ed-script (format "\
/@node Top
/@node/i
@node ~a
@chapter ~a

@verbatiminclude ~a

.
w
" chapter-file-basename chapter-file-basename chapter-file)))
      (sh-run
        {
          $(display ed-script) | ed --script (values texi-file) >/dev/null
        }))))

(define diary2info
  (lambda (diary)
    (let* ((diary-basename (basename diary))
           (diary-file (string-append diary "/" diary-basename ".txt")))
      (if (file-regular? diary-file)
        (let* ((temp-file (string-append temp-dir "/" diary-basename ".texi"))
               (other-files (sh-run/string-split-after-nuls
                              {find (values diary) -type f -not -name (basename diary-file) -print0}))
               (chapter-files (filter utf8? other-files)))
          (diary2texi diary-file temp-file)
          (for-each (lambda (chapter-file) (texi-prepend-chapter temp-file chapter-file)) chapter-files)
          (texi2info temp-file)
)))))

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
       (cond
         ((string-digits-only? (basename note))
          (diary2info note))
         (else
          (dir2info note))))
)))

(sh-run {rm -rf (values temp-dir)})
(sh-run {mkdir -p (values temp-dir)})

(for-each note2info notes)

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

(for-each add-info-entry-to-dirfile infos-without-dirfile)



(flush-output-port)
