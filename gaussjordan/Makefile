compile:
	@rm -rf src/*.erl~
	@for FILE in `ls src/ | grep .erl`;\
    	do\
        erlc -I include/ -o ebin/ src/$$FILE;\
        echo "erlc -I include/ -o ebin/ $$FILE";\
	done
clear:
	@rm -rf ebin/*.beam
start:
	erl -pa ebin
