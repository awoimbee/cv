
## /!\ NON STANDARD MAKEFILE

TMP_DIR:=tmp

define gen_lang_pdf
	cp resume.tex $(TMP_DIR)/resume_$(1).tex
	sed 's|\\newcommand\\$(1)\[1\]{}|\\newcommand\\$(1)[1]{#1}|g' $(TMP_DIR)/resume_$(1).tex > $(TMP_DIR)/tmp && mv $(TMP_DIR)/tmp $(TMP_DIR)/resume_$(1).tex
	cd $(TMP_DIR); pdflatex resume_$(1).tex
endef

all:
	mkdir -p $(OUT_DIR) $(TMP_DIR) | true
	$(call gen_lang_pdf,en)
	$(call gen_lang_pdf,fr)
	mv $(TMP_DIR)/*.pdf .

clean:
	rm -rf $(TMP_DIR)

fclean: clean
	rm resume_en.pdf
	rm resume_fr.pdf
