################################################################
## Synchronize web site on the server

targets:
	@echo "Targets"
	@echo "	clean 		remove temporary files left by emacs"
	@echo "	publish		push changes to github"
	@echo "	local		open local version of the web pages"
	@echo "	web		open web pages"
	@echo "	repo		open repositoruy on github"

################################################################
## Clean temporary files created by emacs
clean:
	find . -name '*~' -exec rm {} \;
	find . -name '.#*' -exec rm {} \;
	find . -name '.DS_Store' -exec rm {} \;


################################################################
## Publish on the web site
TO_SYNC=*
publish: clean
	git push

################################################################
## Browse the Web site
#BROWSER=firefox
LOCAL=README.html
local:
	@echo "	LOCAL	${LOCAL}"
	@open  ${LOCAL}

#WEB_URL=http://pedagogix-tagc.univ-mrs.fr/courses/SBBCU16L_cisreg
WEB_URL=http://jvanheld.github.io/stat1
web:
	@echo "	WEB_URL	${WEB_URL}"
	@open  ${WEB_URL}

## Open repository on github
REPO=https://github.com/jvanheld/stat1
repo:
	@echo "	REPO	${REPO}"
	@open ${REPO}
