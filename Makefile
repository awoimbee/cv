
TMP_DIR:=tmp

define gen_lang_pdf
	cp cv.tex $(TMP_DIR)/cv_$(1).tex
	sed 's|\\newcommand\\$(1)\[1\]{}|\\newcommand\\$(1)[1]{#1}|g' $(TMP_DIR)/cv_$(1).tex > $(TMP_DIR)/tmp && mv $(TMP_DIR)/tmp $(TMP_DIR)/cv_$(1).tex
	cd $(TMP_DIR); pdflatex cv_$(1).tex
endef

.PHONY: all clean fclean

all:
	mkdir -p $(OUT_DIR) $(TMP_DIR) | true
	$(call gen_lang_pdf,en)
	$(call gen_lang_pdf,fr)
	mv $(TMP_DIR)/*.pdf .

clean:
	rm -rf $(TMP_DIR)

fclean: clean
	rm cv_en.pdf
	rm cv_fr.pdf
