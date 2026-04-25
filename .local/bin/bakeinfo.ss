#!/usr/bin/env schemesh

;; https://github.com/cosmos72/schemesh#shell-wildcards

(define note-dir (shell-string {$AIDAN_GIT/note}))

(define notes
  (sh-run/string-split-after-nuls
    {find (values note-dir) -mindepth 1 -maxdepth 1 -not -name ".*" -print0}))

(define info-dir (shell-string {$HOME/info}))

(define texi2info
  (lambda (texi)
    (sh-run
      {
        texi2any \
        --set-customization-variable paragraphindent=asis \
        --info \
        --no-split \
        (string-append "--output=" info-dir) \
        (values texi) \
      })))

(define basename
  (lambda (path)
    (car (sh-run/string-split-after-nuls {basename --zero (values path)}))))

(define dir2info
  (lambda (dir)
    (texi2info (string-append dir "/" (basename dir) ".texi"))
    (for-each
      (lambda (attachment)
        (sh-run {cp (values attachment) (string-append info-dir "/" (basename attachment))}))
      (sh-run/string-split-after-nuls
        {find (values dir) -type f -not -name "*.texi" -print0}))))

(define note2info
  (lambda (note)
    (cond
      ((file-regular? note)
       (cond
         ((string-suffix? note ".texi")
          (texi2info note))
         ((string-suffix? note ".txt")
          (void))))
      ((file-directory? note)
       (dir2info note)))))

(for-each note2info notes)



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
