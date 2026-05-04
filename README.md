# COBOL Inventory Management System

[English](#english) | [Português (Brasil)](#português-brasil) | [Español](#español)

---

## English

A sophisticated inventory management system developed in COBOL, utilizing **Indexed Files (ISAM)** for high-performance data access and a professional **Screen Section** interface.

### Engineering Highlights
- **Indexed Data Management**: Uses ISAM (Indexed Sequential Access Method) for instant CRUD operations by Primary Key (`PROD-ID`).
- **Professional UI**: Implements terminal-based screens with colors, field masking, and explicit positioning.
- **Dual-Standard Portability**: Fully functional in both `Free Format` (Modern) and `Fixed Format` (ANSI-85/Mainframe).
- **Advanced Navigation**: Features a paginated general report using `START` and `READ NEXT` cursor logic.
- **Robustness**: Comprehensive `FILE STATUS` handling and automatic data file initialization.

### Project Structure
- `src/pgm/fixed/`: Mainframe-standard source code.
- `src/pgm/free/`: Modern-standard source code.
- `src/cpy/`: Reusable copybooks for data layouts.
- `data/`: Indexed database storage (`.dat` and `.idx` files).

### How to Run
```bash
make build-free   # Build modern version
make run-free     # Launch the system
make build-fixed  # Build mainframe version
```

---

## Português (Brasil)

Sistema sofisticado de gestão de estoque desenvolvido em COBOL, utilizando **Arquivos Indexados (ISAM)** para acesso de alta performance e interface profissional via **Screen Section**.

### Diferenciais de Engenharia
- **Gestão Indexada**: Utiliza ISAM para operações CRUD instantâneas através de Chave Primária (`PROD-ID`).
- **UI Profissional**: Interface de terminal com cores, máscaras de campos e posicionamento explícito.
- **Portabilidade Dual-Standard**: Código 100% funcional em `Free Format` (Moderno) e `Fixed Format` (ANSI-85/Mainframe).
- **Navegação Avançada**: Relatório geral paginado utilizando lógica de cursor com `START` e `READ NEXT`.
- **Robustez**: Tratamento exaustivo de `FILE STATUS` e inicialização automática de arquivos de dados.

### Como Executar
```bash
make build-free   # Compilar versão moderna
make run-free     # Iniciar o sistema
make build-fixed  # Compilar versão mainframe
```

---

## Español

Sistema sofisticado de gestión de inventarios desarrollado en COBOL, que utiliza **Archivos Indexados (ISAM)** para acceso a datos de alto rendimiento e interfaz profesional **Screen Section**.

### Aspectos Destacados de Ingeniería
- **Gestión de Datos Indexados**: Utiliza ISAM para operaciones CRUD instantáneas mediante Clave Primaria (`PROD-ID`).
- **Interfaz Profesional**: Implementa pantallas de terminal con colores, máscaras de campo y posicionamiento explícito.
- **Portabilidad Dual**: Totalmente funcional tanto en `Free Format` (Moderno) como en `Fixed Format` (ANSI-85/Mainframe).
- **Navegação Avanzada**: Incluye un informe general paginado utilizando lógica de cursor con `START` y `READ NEXT`.
- **Robustez**: Manejo integral de `FILE STATUS` e inicialización automática de archivos de datos.

### Cómo Ejecutar
```bash
make build-free   # Compilar versión moderna
make run-free     # Iniciar el sistema
make build-fixed  # Compilar versión mainframe
```
