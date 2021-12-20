all: build tests run
build:
	docker build -t archstudylesson3 .
tests:
	docker run -it --rm --name archstudylesson3 archstudylesson3 prove -r ./t
run:
	docker run -it --rm --name archstudylesson3 archstudylesson3
test:
	docker run -it --rm --name archstudylesson3 archstudylesson3 perl ./t/Calc/Calculator/ReversePolish/main_int.t

