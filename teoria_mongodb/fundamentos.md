¿Qué es una base de datos no relacional y qué es MongoDB?

Una base de datos no relacional (NoSQL) es un tipo de base de datos que no organiza la información en tablas con filas y columnas fijas, como lo hace un motor relacional (SQL). En su lugar, guarda los datos en estructuras más flexibles, como documentos, pares clave-valor, grafos o columnas anchas. MongoDB es una base de datos no relacional orientada a documentos: guarda la información en documentos con formato similar a JSON, agrupados en colecciones.

¿Qué son una colección, un documento y un campo?

Una colección es el equivalente a una tabla en un modelo relacional: es un conjunto de documentos relacionados entre sí (por ejemplo, una colección de "canciones"). Un documento es el equivalente a una fila/registro: es una unidad de información completa, guardada en formato tipo JSON. Un campo es el equivalente a una columna: es cada uno de los atributos dentro de un documento (por ejemplo, titulo, duracion, artista).

Diferencias principales entre una tabla relacional y una colección de documentos

•	En una tabla, todas las filas deben tener la misma estructura (mismas columnas); en una colección, cada documento puede tener campos distintos.

•	Una tabla relacional normalmente separa la información en varias tablas conectadas por llaves foráneas; un documento puede incluir información relacionada anidada dentro de sí mismo, sin necesidad de hacer JOIN.

•	El modelo relacional exige definir un esquema fijo antes de insertar datos; MongoDB permite un esquema flexible que puede cambiar con el tiempo.

Dos ventajas y dos limitaciones de MongoDB

Ventajas:

•	Flexibilidad para guardar datos con estructura variable o que cambia frecuentemente, sin tener que alterar un esquema.

•	Buen desempeño para leer y escribir documentos completos, ya que no necesita hacer JOIN entre varias tablas.

Limitaciones:

•	Al no exigir un esquema fijo, es más fácil que se guarden datos inconsistentes o mal estructurados si no se controla desde la aplicación.

•	Las relaciones complejas entre distintos tipos de datos (como las que sí maneja bien un modelo relacional con integridad referencial) son más difíciles de garantizar de forma nativa.

¿En qué situaciones conviene PostgreSQL y en cuáles MongoDB?

PostgreSQL conviene cuando los datos tienen una estructura clara y estable, cuando es importante mantener integridad referencial entre tablas (como en este proyecto, con artistas, canciones, géneros y playlists), y cuando se necesitan transacciones y consultas complejas con JOIN. MongoDB conviene cuando la información tiene una estructura variable o poco predecible, cuando se generan grandes volúmenes de datos que no requieren relaciones estrictas, o cuando se necesita flexibilidad para ir cambiando la forma de los datos con el tiempo.

Dentro de nuestro caso, ¿qué información podría almacenarse en MongoDB y por qué?

En nuestro caso (plataforma de música), la información de artistas, canciones, géneros y playlists tiene una estructura fija y relaciones claras, por lo que tiene sentido mantenerla en PostgreSQL. Sin embargo, algo como el historial de reproducciones de cada canción (qué usuario la reprodujo, en qué momento, desde qué dispositivo, cuánto tiempo la escuchó) podría almacenarse en MongoDB, ya que es información que se genera en grandes volúmenes, no siempre tiene la misma estructura (por ejemplo, algunos eventos podrían incluir datos extra como ubicación o tipo de conexión) y no necesita mantener integridad referencial estricta con el resto de la base.
Ejemplo de un registro del proyecto como documento JSON

{

  "id_reproduccion": "6512f3a9b8e4a2",
  
  "id_cancion": 3,
  
  "titulo": "Get Lucky",
  
  "artista": "Daft Punk",
  
  "fecha_reproduccion": "2026-08-15T21:34:00Z",
  
  "dispositivo": "móvil",
  
  "duracion_escuchada_seg": 245,
  
  "completa": true
  
}
