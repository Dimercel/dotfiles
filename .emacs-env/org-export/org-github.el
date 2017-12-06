;;; org-github.el - custom org-mode html exporter
;;; Create html-document like GitHub Org page

(require 'ox)
(require 'ox-publish)
(require 'ox-html)


(org-export-define-derived-backend 'org-github 'html
  :menu-entry
  '(?h "Export to HTML"
       ((?g "As GitHub org-file" org-github-export-to-html)))
  :translate-alist '((inner-template . org-github-inner-template)
                     (src-block . org-github-src-block)))

(defun org-github-src-block (src-block contents info)
  (let* ((lang (org-element-property :language src-block))
         (code-info (org-export-unravel-code src-block))
         (code (car code-info)))
  (format "<pre><code class=\"%s\">%s</code></pre>" lang code)))

(defun org-github-inner-template (contents info)
  (concat "<div class=\"container\">"
          "<article class=\"markdown-body entry-content\">"
          (org-html-inner-template contents info)
          "</article>"
          "</div>"))

;;;###autoload
(defun org-github-export-to-html
  (&optional async subtreep visible-only body-only ext-plist)
  (interactive)
  (let* ((extension (concat ".html" ))
	 (file (org-export-output-file-name extension subtreep))
	 (org-export-coding-system 'utf-8))
    (org-export-to-file 'org-github file
      async subtreep visible-only body-only ext-plist)))

(provide 'org-github)
