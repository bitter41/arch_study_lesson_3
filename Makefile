all: build test tests
build:
	docker build -t archstudylesson3 .
tests:
	docker run -it --rm --name archstudylesson3 archstudylesson3 prove -r ./t
run:
	docker run -it --rm --name archstudylesson3 archstudylesson3
test:
	docker run -it --rm --name archstudylesson3 archstudylesson3 perl ./t/Calc/ExpressionConvertor/SimpleToReversePolish/main_int.t

