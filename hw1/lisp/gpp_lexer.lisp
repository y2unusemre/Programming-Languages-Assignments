(defun check (x)



	(if (string-equal x "and")		(format t "KW_AND~%") )
	(if (string-equal x "or")		(format t "KW_OR~%") )
	(if (string-equal x "not")		(format t "KW_NOT~%") )
	(if (string-equal x "equal")	(format t "KW_EQUAL~%") )
	(if (string-equal x "less")		(format t "KW_LESS~%") )
	(if (string-equal x "nil")		(format t "KW_NIL~%") )
	(if (string-equal x "list")		(format t "KW_LIST~%") )
	(if (string-equal x "append")	(format t "KW_APPEND~%") )
	(if (string-equal x "concat")	(format t "KW_CONCAT~%") )
	(if (string-equal x "set")		(format t "KW_SET~%") )
	(if (string-equal x "deffun")	(format t "KW_DEFFUN~%") )
	(if (string-equal x "for")		(format t "KW_FOR~%") )
	(if (string-equal x "if")		(format t "KW_IF~%") )
	(if (string-equal x "exit")		(format t "KW_EXIT~%") )
	(if (string-equal x "load")		(format t "KW_LOAD~%") )
	(if (string-equal x "disp")		(format t "KW_DISP~%") )
	(if (string-equal x "true")		(format t "KW_TRUE~%") )
	(if (string-equal x "false")	(format t "KW_FALSE~%") )
	(if (string-equal x "+")		(format t "OP_PLUS~%") )
	(if (string-equal x "-")		(format t "OP_MINUS~%") )
	(if (string-equal x "/")		(format t "OP_DIV~%") )
	(if (string-equal x "*")		(format t "OP_MULT~%") )
	(if (string-equal x "(")		(format t "OP_OP~%") )
	(if (string-equal x ")")		(format t "OP_CP~%") )
	(if (string-equal x ";")		(format t "COMMENT~%") )	
;	(if (string-equal x "**")		(format t "OP_DBLMULT~%") )



)





(defun gppinterpreter (&optional file_name)

;	(format t "~a" name)
;	SplitStr(name)
	
	;(defun iterate (SplitStr(name)) (if (atom l) ((check l) ) (mapcar #'iterate l)))
	
	(defvar input)
	(loop 
		(setq input(read))
		(check input)
		(terpri)
		(when (string-equal input "terminate") (return 0))
	)

#||	(defvar name2 (read))
	(check name2)
	(defvar name3 (read))
	(check name3)
	(defvar name4 (read))
	(check name4)
	(defvar name5 (read))
	(check name5)
||#


)
 

(gppinterpreter)