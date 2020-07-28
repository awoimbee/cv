
TMP_DIR:=tmp

define gen_lang_pdf
	cp src/cv.tex $(TMP_DIR)/cv_$(1).tex
	sed 's|\\newcommand\\$(1)\[1\]{}|\\newcommand\\$(1)[1]{#1}|g' $(TMP_DIR)/cv_$(1).tex > $(TMP_DIR)/tmp && mv $(TMP_DIR)/tmp $(TMP_DIR)/cv_$(1).tex
	cd $(TMP_DIR); pdflatex cv_$(1).tex
endef

.PHONY: all clean fclean

all: cv_en.pdf cv_fr.pdf resume_fr.pdf

$(TMP_DIR):
	mkdir -p $(TMP_DIR) | true

cv_en.pdf: src/cv.tex | $(TMP_DIR)
	$(call gen_lang_pdf,en)
	mv $(TMP_DIR)/$@ .

cv_fr.pdf: src/cv.tex | $(TMP_DIR)
	$(call gen_lang_pdf,fr)
	mv $(TMP_DIR)/$@ .

resume_fr.pdf: src/resume_fr.odt
	libreoffice --headless --convert-to pdf $<

clean:
	rm -rf $(TMP_DIR)

fclean: clean
	rm -f cv_en.pdf cv_fr.pdf resume_fr.pdf
