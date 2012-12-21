#CFLAGS = -D CEU_DEBUG -D DEBUG
#CFLAGS = -DDEBUG -g -O0 -v -da -Q #-pg
# valgrind --error-limit=no --leak-check=full ./mtg_trader
# valgrind --tool=massif ./mtg_trader
# ms_print massif.out.19214 |less

all:
	ceu mtg_trader.ceu --m4 --tp-word 4 --tp-pointer 4
	gcc -Os main.c $(CFLAGS) -lSDL2 -lSDL2_image -lSDL2_mixer -lSDL2_ttf \
		-lGL -llua \
		-o mtg_trader

clean:
	rm -f a.out *.exe _ceu_

.PHONY: all clean
