;; if a region is selected, will format only the json
;; in the region, otherwise it will select the entire
;; buffer
(defun format-json()
  "make json pretty"
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python3 -mjson.tool" (current-buffer) t)))

(defun format-xml()
  "make xml pretty"
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "xmllint --format -" (current-buffer) t)))

;; (defun ruby-pretty-print()
;;   "use ruby pretty print"
;;   (interactive)
;;   (let ((b (if mark-active (min (point) (mark)) (point-min)))
;;         (e (if mark-active (max (point) (mark)) (point-max))))
;;     (shell-command-on-region b e
;;      "ruby -e 'require \"pp\"; pp(eval(ARGF.read));' -" (current-buffer) t)))
