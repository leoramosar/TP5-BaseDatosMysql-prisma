Consigna 3: Prisma Híbrido

3.1. Diferencia entre queryRaw y executeRaw

$queryRaw: Se utiliza para ejecutar consultas SQL que devuelven datos (como SELECT). El método retorna un arreglo de objetos (las filas resultantes de la consulta). Es ideal para reportes, agregaciones complejas o lecturas que el ORM no puede resolver de forma nativa.

$executeRaw: Se utiliza para ejecutar sentencias SQL que modifican datos (como INSERT, UPDATE o DELETE). En lugar de devolver filas, retorna un número entero que indica la cantidad de filas afectadas por la operación.

3.2. Protección contra Inyección SQL con Template Literals
Prisma utiliza literales de plantilla etiquetados (tagged template literals) para las consultas SQL crudas. Cuando escribimos prisma.
queryRaw‘SELECT∗FROMUserWHEREid={id}`, Prisma no concatena el string de forma insegura. En su lugar, envía la consulta y los valores por separado al motor de base de datos (utilizando prepared statements o parametrización).
Esto protege la aplicación porque si un usuario malintencionado ingresa un valor como 1 OR 1=1 o '; DROP TABLE users; --, la base de datos lo tratará como un valor literal y no como código SQL ejecutable. Por el contrario, concatenar strings tradicionales (ej. "SELECT * FROM User WHERE id = " + id) es sumamente peligroso porque permite que el input del usuario altere la estructura misma de la consulta.

3.3. ¿Cuándo abandonar Prisma Client y usar SQL puro?
Aunque Prisma Client es muy potente, hay situaciones específicas donde es mejor usar SQL puro:

Agregaciones complejas: Prisma groupBy tiene limitaciones (por ejemplo, no permite agrupar por funciones como DATE_FORMAT o hacer HAVING complejos).

Reportes analíticos: Consultas con múltiples subconsultas, CTEs (Common Table Expressions) o UNION que son difíciles de modelar con el ORM.

Rendimiento extremo: Cuando se necesita un fine-tuning de la consulta que el ORM genera de forma subóptima (por ejemplo, forzar el uso de un índice específico).

Funciones nativas del motor: Uso de funciones de ventana (Window Functions), procedimientos almacenados o funciones específicas de MySQL que Prisma no expone de forma nativa.

En nuestro proyecto, usamos SQL puro (con $queryRaw) en los endpoints de total-por-mes (pedidos) e iva-por-mes (facturas), justamente porque requieren agrupar por una función de fecha (DATE_FORMAT) que Prisma Client no soporta de forma nativa.

3.4. Informe generado con SQL puro en el proyecto
Se implementaron dos endpoints que generan informes utilizando consultas SQL puras mediante prisma.$queryRaw:

GET /pedidos/total-por-mes: Devuelve la cantidad de pedidos agrupados por mes.

GET /facturas/iva-por-mes: Devuelve el total de subtotal, IVA y facturación agrupados por mes.