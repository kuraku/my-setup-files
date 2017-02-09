;; for (xml-escape-string)
(require 'xml)

;; see http://developer.hatena.ne.jp/ja/documents/blog/apis/atom
(setq my-hatena-id "ulittlegray")
(setq my-hatena-blog-api-key  "p9iurtv3nq")
(setq my-hatena-blog-id "meikyufx.hatenablog.jp")
(setq my-hatena-blog-file-path "~/hatena/blog.md")
(setq my-hatena-blog-backup-dir "~/hatena/blog-entries/")
(setq my-hatena-blog-xml-template "<?xml version='1.0' encoding='utf-8'?>
<entry xmlns='http://www.w3.org/2005/Atom'
       xmlns:app='http://www.w3.org/2007/app'>
  <title>%s</title>
  <author><name>%s</name></author>
  <content type='text/plain'>%s</content>
  <updated>%s</updated>
  <category term='%s' />
  <app:control>
    <app:draft>%s</app:draft>
  </app:control>
</entry>")

(defun my-hatena-blog-build-xml ()
  (interactive)
  (let ((blog-title (read-string "Title: "
                                 (save-excursion (beginning-of-buffer)
                                                 (search-forward-regexp "#* \\(.*\\)" nil t)
                                                 (match-string 1))))
        (blog-category (read-string "Category: "))
        (blog-is-draft (if (y-or-n-p "Send as draft? ") "yes" "no")))
    (princ (format my-hatena-blog-xml-template
                   (xml-escape-string blog-title)
                   my-hatena-id
                   (xml-escape-string (buffer-string))
                   (format-time-string "%Y-%m-%dT%H:%M:%S")
                   (xml-escape-string blog-category)
                   blog-is-draft))))

(defun my-hatena-blog-post2 ()
  (interactive)
  (let* ((url-request-method "POST")
         (url-request-extra-headers
          `(("Content-Type" . "application/x-www-form-urlencoded")
            ("Authorization" . ,(concat "Basic " (base64-encode-string (concat my-hatena-id ":" my-hatena-blog-api-key))))))
         (url-request-data
          (encode-coding-string (my-hatena-blog-build-xml) 'utf-8))
         (post-url (format "https://blog.hatena.ne.jp/%s/%s/atom/entry" my-hatena-id my-hatena-blog-id)))

    (url-retrieve post-url (lambda (data)
                             (with-current-buffer (current-buffer)
                               (if (search-forward-regexp "HTTP/1.1 201 Created" nil t)
                                   (message "Entry created.")
								 (progn
								   (message "failed!"))))))));

(defun my-hatena-blog-write ()
  (interactive)
  (find-file my-hatena-blog-file-path))

(defun my-hatena-blog-post ()
  (interactive)
  (my-hatena-blog-post2)
  (write-file (concat my-hatena-blog-backup-dir (format-time-string "%Y-%m-%d-%H-%M-%S") ".md"))
  (move-file-to-trash my-hatena-blog-file-path))


#(evil-leader/set-key "mbw" 'my-hatena-blog-write)
#(evil-leader/set-key-for-mode 'markdown-mode "mbp" 'my-hatena-blog-post)
