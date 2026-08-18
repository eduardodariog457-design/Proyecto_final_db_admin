
import subprocess
import sys
import os
from datetime import datetime

DB = "final_db"
USER = "postgres"
BACKUP_DIR = "backups"
LOG_DIR = "logs"
SQL_MANTENIMIENTO = os.path.join("sql", "07_mantenimiento.sql")

FECHA = datetime.now().strftime("%Y%m%d_%H%M%S")

os.makedirs(BACKUP_DIR, exist_ok=True)
os.makedirs(LOG_DIR, exist_ok=True)

log_path = os.path.join(LOG_DIR, f"mantenimiento_{FECHA}.log")


def log(mensaje):
    """Imprime en consola y guarda en el archivo de log."""
    print(mensaje)
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(mensaje + "\n")


def ejecutar(comando, descripcion):
    log(f"\n=== {descripcion} ===")
    resultado = subprocess.run(comando, capture_output=True, text=True)
    if resultado.stdout:
        log(resultado.stdout)
    if resultado.stderr:
        log(resultado.stderr)
    if resultado.returncode != 0:
        log(f"ERROR: '{descripcion}' fallo. Revisa {log_path}")
        sys.exit(1)


def main():
    log(f"=== Inicio del proceso: {datetime.now()} ===")

    dump_path = os.path.join(BACKUP_DIR, f"respaldo_{FECHA}.dump")
    ejecutar(
        ["pg_dump", "-U", USER, "-d", DB, "-F", "c", "-f", dump_path],
        "1/3 Generando respaldo comprimido..."
    )
    log(f"    Respaldo guardado en {dump_path}")

    ejecutar(
        ["psql", "-U", USER, "-d", DB, "-f", SQL_MANTENIMIENTO],
        "2/3 Ejecutando mantenimiento y generando reporte..."
    )

    log("3/3 Proceso completado.")
    log(f"Revisa el detalle completo en: {log_path}")
    log(f"=== Fin del proceso: {datetime.now()} ===")


if __name__ == "__main__":
    main()
