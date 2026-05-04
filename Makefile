# Makefile para Sistema de Gestao de Estoque (Indexado)

# Compilador e Flags
COBC = cobc
CPY_DIR = src/cpy
FLAGS_FIXED = -x -O2 -I $(CPY_DIR)
FLAGS_FREE  = -x -free -O2 -I $(CPY_DIR)

# Diretorios
BIN_DIR = bin
DATA_DIR = data
SRC_FIXED = src/pgm/fixed
SRC_FREE  = src/pgm/free

# Alvos
all: setup build-free

setup:
	mkdir -p $(BIN_DIR)
	mkdir -p $(DATA_DIR)

build-free: setup
	$(COBC) $(FLAGS_FREE) -o $(BIN_DIR)/estoque-free $(SRC_FREE)/ESTOQUE.cob

# Alvo para futura versao fixed
build-fixed: setup
	@if [ -f $(SRC_FIXED)/ESTOQUE.cob ]; then \
		$(COBC) $(FLAGS_FIXED) -o $(BIN_DIR)/estoque-fixed $(SRC_FIXED)/ESTOQUE.cob; \
	else \
		echo "Aviso: Fonte Fixed Format ainda nao criado."; \
	fi

run-free:
	./$(BIN_DIR)/estoque-free

clean:
	rm -rf $(BIN_DIR)
	# Nao removemos a pasta data/ para preservar o banco de dados indexado, 
	# a menos que seja um clean-all
	rm -f *.lst

clean-all: clean
	rm -rf $(DATA_DIR)/*.dat $(DATA_DIR)/*.idx
