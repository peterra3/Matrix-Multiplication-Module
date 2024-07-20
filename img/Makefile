systolic:
	pdflatex -shell-escape lab3.tex
	pdfcrop lab3.pdf
	convert -density 300 lab3-crop.pdf systolic.png

4x4:
	pdflatex -shell-escape lab3-4x4.tex
	pdfcrop lab3-4x4.pdf
	convert -density 300 lab3-4x4-crop.pdf 4x4.png

8x8-1:
	pdflatex -shell-escape lab3-8x8-1.tex
	pdfcrop lab3-8x8-1.pdf
	convert -density 500 lab3-8x8-1-crop.pdf 8x8-1.png

8x8-2:
	pdflatex -shell-escape lab3-8x8-2.tex
	pdfcrop lab3-8x8-2.pdf
	convert -density 500 lab3-8x8-2-crop.pdf 8x8-2.png

8x8-3:
	pdflatex -shell-escape lab3-8x8-3.tex
	pdfcrop lab3-8x8-3.pdf
	convert -density 500 lab3-8x8-3-crop.pdf 8x8-3.png

8x8-4:
	pdflatex -shell-escape lab3-8x8-4.tex
	pdfcrop lab3-8x8-4.pdf
	convert -density 500 lab3-8x8-4-crop.pdf 8x8-4.png

clean:
	rm -Rf *.out *.snm *.log *.toc *aux *.nav *-crop.pdf *.pdf _minted*
