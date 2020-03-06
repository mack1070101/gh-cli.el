;;; gh-cli.el --- An Emacs wrapper for gh  -*- lexical-binding: t; coding: utf-8 -*-

;; Author: Mackenzie Bligh <mackenziebligh@gmail.com>

;; Keywords: git tools vc
;; Version: 0.0.1

;; gh-cli.el is distributed in the hope that it will be useful, but without
;; any warranty; without even the implied warranty of merchantability
;; or fitness for a particular purpose. See the gnu general public
;; license for more details.
;;
;; You should have received a copy of the gnu general public license
;; along with gh-cli.el  if not, see http://www.gnu.org/licenses.

;;; Commentary:
;; TODO FIX transient pass through

;;; Code:
(require 'transient)

(setq gh-cli-command "gh")
(setq gh-cli-issue-command "issue")
(setq gh-pr-command "pr")

;;;###autoload (autoload 'gh-cli-dispatch "gh-cli.el" nil t)
(define-transient-command gh-cli-dispatch ()
  "Invoke a gh command from a list of available commands"
  ["Flags"
   (gh-cli-help:-h)
   (gh-cli-repo:-r)]
  ["Commands"
   ("i" "issue" gh-cli-issue-dispatch)
   ("p" "pr" gh-cli-pr-dispatch)])

;;;###autoload (autoload 'gh-issue-dispatch "gh-cli.el" nil t)
(define-transient-command gh-cli-issue-dispatch ()
  "Invoke a gh issue [command]"
  ["Flags"
   (gh-cli-help:-h)
   (gh-cli-repo:-r)]
  ["Commands"
   ("c" "create" gh-cli-issue-create)
   ("l" "list" gh-cli-issue-list)
   ("s" "status" gh-cli-issue-status)
   ("v" "view" gh-cli-issue-view)])

;;;###autoload (autoload 'gh-pr-dispatch "gh-cli.el" nil t)
(define-transient-command gh-cli-pr-dispatch ()
  "Invoke a gh pr [command]"
  ["Flags"
   (gh-cli-help:-h)
   (gh-cli-repo:-r)]
  ["Commands"
   ("c" "checkout" gh-cli-pr-checkout)
   ("C" "create" gh-cli-pr-create)
   ("l" "list" gh-cli-pr-list)
   ("s" "status" gh-cli-pr-status)
   ("v" "view" gh-cli-pr-view)])

;;;###autoload
(defun gh-cli-issue-create ()
  "Invoke the gh issue create command"
  (interactive)
  (gh-cli-command gh-cli-issue-command
                  "create "
                  'gh-cli-issue-dispatch))

;;;###autoload
(defun gh-cli-issue-list ()
  "Invoke the gh issue create command"
  (interactive)
  (gh-cli-command gh-cli-issue-command
                  "list "
                  'gh-cli-issue-dispatch))

;;;###autoload
(defun gh-cli-issue-status ()
  "Invoke the gh issue create command"
  (interactive)
  (gh-cli-command gh-cli-issue-command
                  "status "
                  'gh-cli-issue-dispatch))

;;;###autoload
(defun gh-cli-issue-view()
  "Invoke the gh issue create command"
  (interactive)
  (gh-cli-command gh-cli-issue-command
                  "view"
                  'gh-cli-issue-dispatch))

;;;###autoload
(defun gh-cli-pr-checkout ()
  "Invoke the gh pr checkout command"
  (interactive)
  (gh-cli-command gh-pr-command
                  "checkout "
                  'gh-cli-pr-dispatch))

;;;###autoload
(defun gh-cli-pr-create()
  "Invoke the gh pr checkout command"
  (interactive)
  (gh-cli-command gh-pr-command
                  "create "
                  'gh-cli-pr-dispatch))

;;;###autoload
(defun gh-cli-pr-list ()
  "Invoke the gh pr list command"
  (interactive)
  (gh-cli-command gh-pr-command
                  "list "
                  'gh-cli-pr-dispatch))

;;;###autoload
(defun gh-cli-pr-status ()
  "Invoke the gh pr status command"
  (interactive)
  (gh-cli-command gh-pr-command
                  "status "
                  'gh-cli-pr-dispatch))

;;;###autoload
(defun gh-cli-pr-view ()
  "Invoke the gh pr view command"
  (interactive)
  (gh-cli-command gh-pr-command
                  "view "
                  'gh-cli-pr-dispatch))

;;;###autoload
(defun gh-cli-command (command-name action dispatch-func)
  (interactive)
  (async-shell-command
   (string-join (list gh-cli-command
                      command-name
                      action
                      (string-join (transient-args dispatch-func) " "))
                " ")))

(define-infix-argument gh-cli-help:-h ()
  :description "Show help for command"
  :key "-h"
  :argument "--help ")

(define-infix-argument gh-cli-repo:-r ()
  :description "Select another repository using the OWNER/REPO format"
  :class 'transient-option
  :key "-R"
  :argument "--repo ")
;;; gh-cli.el ends here
