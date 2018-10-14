TEXINFO_TEX=../texinfo.tex
info_TEXINFOS = 
if CHM
genericdirDATA = \
contents.hhc index.hhk header.hhp
endif

all-local: maxima.info maxima-index.lisp maxima.html contents.hhc

LANGSRCDIR = $(srcdir)/../$(INFOLANG)
LANGBUILDDIR = $(builddir)/../$(INFOLANG)
langsdir = /$(INFOLANG).utf8

MAKEINFOFLAGS = --enable-encoding

if USE_RECODE
    urecode=true
endif

fcharset = ISO-8859-1
tcharset = UTF-8

fhtmlcharset = iso-8859-1
thtmlcharset = utf-8

maxima-index.lisp: $(top_srcdir)/doc/info/build_index.pl maxima.info
	perl $^ ':utf8' > $@

include $(top_srcdir)/common.mk

EXTRA_DIST = maxima-index.lisp $(genericdirDATA)

maxima.info: $(LANGSRCDIR)/maxima.texi
	@rm -f maxima.info* 2>/dev/null
	$(MAKEINFO) $(AM_MAKEINFOFLAGS) $(MAKEINFOFLAGS) \
	  -I $(LANGSRCDIR) -I $(LANGBUILDDIR) $<
	for f in $@ $@-[0-9] $@-[0-9][0-9]; do \
	    if test -f $$f; then \
		if test x$(urecode) = xtrue ; then \
		    recode $(fcharset)..$(tcharset) $$f ; \
		else \
		    rm -f foo.$$f 2>/dev/null ; \
		    iconv -f $(fcharset) -t $(tcharset) $$f > foo.$$f ; \
		    mv -f foo.$$f $$f ; \
		fi; \
	    fi; \
	done

maxima.html: $(LANGSRCDIR)/maxima.texi
	rm -f maxima*.html 2>/dev/null
	@: $(MAKEINFOHTML) $(AM_MAKEINFOHTMLFLAGS) $(MAKEINFOHTMLFLAGS) \
	  -I $(LANGSRCDIR) -I $(LANGBUILDDIR) --init-file=$(srcdir)/../texi2html.init \
	   --split=chapter --output=. --css-include=../manual.css $<
	perl $(srcdir)/../texi2html --split_chapter --lang=es --output=. \
	  --css-include=$(srcdir)/../manual.css \
	  -I $(LANGSRCDIR) -I $(LANGBUILDDIR) \
	  --init-file $(srcdir)/../texi2html.init \
	  $<
	for f in maxima*.html; do \
	    if test x$(urecode) = xtrue ; then \
	        recode $(fcharset)..$(tcharset) $$f ; \
	    else \
	        rm -f foo.$$f 2>/dev/null ; \
	        iconv -f $(fcharset) -t $(tcharset) $$f > foo.$$f ; \
	        mv -f foo.$$f $$f ; \
	    fi; \
	done
	for f in maxima*.html; do \
	    rm -f foo.$$f 2>/dev/null ; \
	    sed -e "s|charset=$(fhtmlcharset)|charset=$(thtmlcharset)|" < $$f > foo.$$f ; \
	    mv -f foo.$$f $$f ; \
	done

contents.hhc: maxima.html
	perl $(top_srcdir)/doc/info/create_index

infoname = maxima
include $(top_srcdir)/common-info.mk
htmlinstdir = $(dochtmldir)/$(INFOLANG).utf8
htmlname=maxima
include $(top_srcdir)/common-html.mk

clean-local: clean-info clean-html clean-texi

clean-info:
	rm -f $(wildcard maxima*.info maxima-index.lisp) \
	      $(wildcard $(srcdir)/maxima*.info $(srcdir)/maxima-index.lisp)
	rm -f maxima-index.lisp

clean-html:
	rm -f index.hhk
	rm -f $(wildcard maxima*.html contents.hhc index.hhk maxima.chm) \
	      $(wildcard $(srcdir)/maxima*.html $(srcdir)/contents.hhc $(srcdir)/index.hhk $(srcdir)/maxima.chm)

clean-texi:
	rm -f $(wildcard *.texi $(srcdir)/*.texi)
