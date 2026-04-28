#!/usr/bin/env schemesh

;; https://github.com/cosmos72/schemesh#shell-wildcards

;; # make info

(define note-dir (shell-string {$AIDAN_GIT/note}))

(define notes
  (sh-run/string-split-after-nuls
    {find (values note-dir) -mindepth 1 -maxdepth 1 -not -name ".*" -print0}))

(define info-dir (shell-string {$HOME/info}))

;; (define texi2info
;;   (lambda (texi)
;;     (sh-run
;;       {
;;         texi2any \
;;         --set-customization-variable paragraphindent=asis \
;;         --info \
;;         --no-split \
;;         (string-append "--output=" info-dir) \
;;         (values texi) \
;;       })))

;; NOTE: for performance, we batch texi2any into a single call
(define texi-queue '())
(define texi2info
  (lambda (texi)
    (set! texi-queue (cons texi texi-queue))))

(define basename
  (lambda (path)
    (sh-run/string-rtrim-newlines {basename (values path)})))

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

(define temp-dir "/tmp/bakeinfo")
(sh-run {rm -rf (values temp-dir)})
(sh-run {mkdir -p (values temp-dir)})
(define txt2info
  (lambda (txt)
    (let* ((txt-basename (basename txt))
           (temp-file
            (sh-run/string-rtrim-newlines
              {
                mktemp \
                (string-append "--tmpdir=" temp-dir) \
                (string-append txt-basename ".XXX" ".texi") \
              }))
           (texi-generated-from-txt (format #f "\
\\input texinfo

@dircategory txt
@direntry
* ~a: (~a).
@end direntry

@node Top
@top ~a

@verbatim
~a
@end verbatim

@bye
" txt-basename txt-basename txt-basename (sh-run/string {cat (values txt)}))))
      (with-output-to-file temp-file (lambda () (display texi-generated-from-txt)))
      (texi2info temp-file)
)))

(define note2info
  (lambda (note)
    (cond
      ((file-regular? note)
       (cond
         ((string-suffix? note ".texi")
          (texi2info note))
         ((string-suffix? note ".txt")
          (txt2info note))))
      ((file-directory? note)
       (dir2info note)))))

(for-each note2info notes)

;; (display texi-queue)

;; NOTE: for performance, we batch texi2any into a single call
(sh-run
  {
    texi2any \
    --set-customization-variable paragraphindent=asis \
    --info \
    --no-split \
    (string-append "--output=" info-dir) \
    (values texi-queue) \
  })

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
