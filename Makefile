
## /!\ NON STANDARD MAKEFILE

TMP_DIR:=tmp

all:
	mkdir -p $(OUT_DIR) $(TMP_DIR) | true
	cp resume.tex $(TMP_DIR)/resume_en.tex
	cp resume.tex $(TMP_DIR)/resume_fr.tex
	sed -i 's|\\newcommand\\en\[1\]{}|\\newcommand\\en[1]{#1}|g' $(TMP_DIR)/resume_en.tex
	sed -i 's|\\newcommand\\fr\[1\]{}|\\newcommand\\fr[1]{#1}|g' $(TMP_DIR)/resume_fr.tex
	cd $(TMP_DIR); pdflatex resume_fr.tex
	cd $(TMP_DIR); pdflatex resume_en.tex
	mv $(TMP_DIR)/*.pdf .

clean:
	rm -rf $(TMP_DIR)

fclean: clean
	rm resume_en.pdf
	rm resume_fr.pdf
