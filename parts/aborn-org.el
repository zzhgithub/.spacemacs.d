;; --------------------------------------------------------------------
;; setting org-mode
;; --------------------------------------------------------------------
;; (setq org-todo-keywords
;; '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "ONGOING(o)" "|" "DONE(d)")))

(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "ONGOING(o!)" "|" "DONE(d!)")
              (sequence "REPORT(r!)" "BUG" "KNOWNCAUSE" "|" "FIXED(f!)")
              (sequence "PAUSED" "BLOCKED" "REVIEW" "|" "CANCELLED(c@)"))))

(setq org-log-done 'time)      ;;  setting close time
;; (setq org-log-done 'note)   ;;  setting a log note
;; (set org-modules 'habits)
(setq org-startup-folded nil)  ;; 打开org文件默认不展开所有
(when (string= system-type "darwin")
  (setq org-directory "/Users/aborn/github/iGTD/mobile")
  (setq org-mobile-directory "/Users/aborn/github/iGTD/mobile")
  (setq org-mobile-inbox-for-pull "/Users/aborn/github/iGTD/from-mobile.org"))

(defun org-agenda-timeline-all (&optional arg)
  (interactive "P")
  (with-temp-buffer
    (dolist (org-agenda-file org-agenda-files)
      (insert-file-contents org-agenda-file nil)
      (end-of-buffer)
      (newline))
    (write-file "/tmp/timeline.org")
    (org-agenda arg "L")))
(define-key org-mode-map (kbd "C-c t") 'org-agenda-timeline-all)

(defface org-progress ; font-lock-warning-face
  (org-compatible-face nil
    '((((class color) (min-colors 16) (background light)) (:foreground "#A197BF" :bold t :background "#E8E6EF" :box (:line-width 1 :color "#A197BF")))
      (((class color) (min-colors 8)  (background light)) (:foreground "blue"  :bold t))
      (t (:inverse-video t :bold t))))
  "Face for PROGRESS keywords."
  :group 'org-faces)
(defface org-paused ; font-lock-warning-face
  (org-compatible-face nil
    '((((class color) (min-colors 16) (background light)) (:foreground "#D6CCF4" :bold t :background "#ECE9F5" :box (:line-width 1 :color "#D6CCF4")))
      (((class color) (min-colors 8)  (background light)) (:foreground "cyan"  :bold t))
      (t (:inverse-video t :bold t))))
  "Face for PAUSED keywords."
  :group 'org-faces)
(defface org-cancelled ; font-lock-warning-face
  (org-compatible-face nil
    '((((class color) (min-colors 16) (background light)) (:foreground "#3D3D3D" :bold t :background "#7A7A7A" :box (:line-width 1 :color "#3D3D3D")))
      (((class color) (min-colors 8)  (background light)) (:foreground "black"  :bold t))
      (t (:inverse-video t :bold t))))
  "Face for PROGRESS keywords."
  :group 'org-faces)
(defface org-review ; font-lock-warning-face
  (org-compatible-face nil
    '((((class color) (min-colors 16) (background light)) (:foreground "#FC9B17" :bold t :background "#FEF2C2" :box (:line-width 1 :color "#FC9B17")))
      (((class color) (min-colors 8)  (background light)) (:foreground "yellow"  :bold t))
      (t (:inverse-video t :bold t))))
  "Face for PROGRESS keywords."
  :group 'org-faces)
(defface org-blocked ; font-lock-warning-face
  (org-compatible-face nil
    '((((class color) (min-colors 16) (background light)) (:foreground "#FF8A80" :bold t :background "#ffdad6" :box (:line-width 1 :color "#FF8A80")))
      (((class color) (min-colors 8)  (background light)) (:foreground "red"  :bold t))
      (t (:inverse-video t :bold t))))
  "Face for PROGRESS keywords."
  :group 'org-faces)

(setq org-todo-keyword-faces
      (quote (("TODO" . org-todo)
              ("ONGOING" . org-progress)
              ("PAUSED" . org-paused)
              ("BLOCKED" . org-blocked)
              ("REVIEW" . org-review)
              ("DONE" . org-done)
              ("ARCHIVED" . org-done)
              ("CANCELLED" . org-cancelled)
              ("REPORT" . org-todo)
              ("BUG" . org-blocked)
              ("KNOWNCAUSE" . org-review)
              ("FIXED" . org-done))))

;; 如果所有的子任务完成了，那标识父任务也完成
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to ONGOING otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "ONGOING"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(setq
 org-completion-use-ido t         ;; use IDO for completion
 org-cycle-separator-lines 0      ;; Don't show blank lines
 org-catch-invisible-edits 'error ;; don't edit invisible text
 org-refile-targets '((org-agenda-files . (:maxlevel . 6)))
 )
(provide 'aborn-org)
