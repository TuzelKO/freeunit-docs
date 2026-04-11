SPHINX		?= sphinx-build
SERVER		?= python3 -mhttp.server

SITEMAP		?= python3 sitemaps.py
URL		?= https://docs.freeunit.org
GOOGLE		?= https://www.google.com/webmasters/tools/ping?sitemap=
BING		?= http://www.bing.com/ping?sitemap=
UNIT_SECURITY	?= https://github.com/freeunitorg/freeunit/raw/main/SECURITY.md
FREEUNIT_KEY	?= https://freeunit.org/media/keys/6C68B7AA.asc

BUILDDIR	?= build
DEPLOYDIR	?= deploy

EXCLUDE = \
	--exclude='.*' \
	--exclude='*.inv' \
	--exclude='*/pygments.css' \
	--exclude='/contents' \
	--exclude='searchindex.js' \
	--exclude='/search'

.PHONY: site serve check clean deploy

site: $(BUILDDIR)
	@$(SPHINX) -E -b nxt_html source "$(BUILDDIR)"
# Note: copy files in _downloads/<HASH>/* to _downloads/* to maintain
# the previous webroot structure for use in internal tests.
	cp $(BUILDDIR)/_downloads/*/* $(BUILDDIR)/_downloads

$(BUILDDIR):
	mkdir "$(BUILDDIR)"
	mkdir "$(BUILDDIR)/keys/"

serve: site
	@cd "$(BUILDDIR)" && $(SERVER)

check:
	@$(SPHINX) -b linkcheck -d "$(BUILDDIR)/.doctrees" source .

clean:
	rm -rf $(BUILDDIR) $(DEPLOYDIR)
	rm -rf source/exts/__pycache__/
	rm -f  output.json output.txt rss.xml

deploy: site
	$(eval TMP := $(shell mktemp -d))
	curl -L $(FREEUNIT_KEY) | gpg --dearmor \
		| tee "$(BUILDDIR)/keys/freeunit-keyring.gpg" > /dev/null
	gpg --dry-run --quiet --import --import-options import-show \
		"$(BUILDDIR)/keys/freeunit-keyring.gpg"
	rsync -rv $(EXCLUDE) "$(BUILDDIR)/" "$(TMP)"
	rsync -rcv --delete --exclude='*.gz' --exclude='tmp.*' \
		  --exclude='/sitemap.xml' "$(TMP)/" "$(DEPLOYDIR)"
	$(SITEMAP) "$(URL)" index.html "$(DEPLOYDIR)" -e sitemapexclude.txt \
		> "$(TMP)/sitemap.xml"
	rsync -rcv "$(TMP)/sitemap.xml" "$(DEPLOYDIR)"
	-rm -rf "$(TMP)"
	mkdir -p $(DEPLOYDIR)/.well-known
	curl -L $(UNIT_SECURITY) -o "$(DEPLOYDIR)/.well-known/security.txt" 2>/dev/null
	chmod -R g=u "$(DEPLOYDIR)"
