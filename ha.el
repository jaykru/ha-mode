;;; ha.el --- Ha major mode

;; Copyright (C) 2001  Free Software Foundation, Inc.

;; Author: Jay Kruer
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;; Setup keymap
(defvar ha-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    (define-key map "\C-c#" 'comment-region)
    map)
  "Keymap for `ha-mode'.")

;; autoload .ha files
(add-to-list 'auto-mode-alist '("\\.ha\\'" . ha-mode))

(defvar ha-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    st)
  "Syntax table for `ha-mode'.")

(defvar ha-mode-highlights
  '(("^\\(\\(\\sw\\|\\s_\\)+\\)\\>:" . font-lock-function-name-face)
    ("r0\\|r2\\|r3\\|r4\\|r5\\|r6\\|r7\\|r8\\|r9\\|r10\\|r11\\|r12\\|r13\\|r14\\|r15\\|r1" . font-lock-variable-name-face)
    ("\\(if\\|go\\ to\\)" . font-lock-keyword-face)
    ))


(define-derived-mode ha-mode fundamental-mode "Ha"
  "A major mode for editing Ha files."
  :syntax-table ha-mode-syntax-table
  (setq comment-start "# ")
  (setq comment-start-skip "#+\\s-*")
  (setq font-lock-defaults '(ha-mode-highlights))
  (setq indent-line-function 'ha-indent-line))

 ;;; Indentation

(defun ha-indent-line ()
  "Indent current line of Ha code."
  (interactive)
  (save-excursion (beginning-of-line)
		  (if (not (or (looking-at "\\(\\sw\\|\\s_\\)+:") (looking-at "\\#\\*")))
		      (indent-line-to 4))))

(provide 'ha)
 ;;; ha.el ends here
