# 📊 Curso de Data Analytics — Proyecto RetailPro

Repositorio con los entregables prácticos del curso de **Data Analytics**, desarrollados sobre el caso de negocio **RetailPro**, una distribuidora de tecnología. El proyecto abarca desde el modelado e ingesta de datos relacionales en **SQL Server** hasta la transformación ETL, modelado dimensional y creación de métricas en **Power BI**.

---

## 🛠️ Tecnologías y Herramientas

* **Motor de Base de Datos:** SQL Server 2025
* **Entorno de Desarrollo SQL:** SQL Server Management Studio (SSMS)
* **Business Intelligence y ETL:** Power BI Desktop (Power Query y DAX)
* **Control de Versiones:** Git & GitHub

---

## 📂 Estructura del Repositorio

```text
curso-data-analytics/
├── modulo-3/
│   └── ventas_tech_db.sql
├── modulo-4/
│   └── m4_consultas_negocio.sql
├── modulo-5/
│   └── m5_consultas_joins.sql
├── modulo-6/
│   └── Pipeline_ETL_Abalos_Joaquin.pbix
├── modulo-8/
│   └── Abalos_Joaquin_Checkpoint2.pbix
└── README.md
```

### Detalle por Módulo

* **`modulo-3/ventas_tech_db.sql`**  
  Script DDL y DML que crea la base de datos **`Ventas_Tech_DB`** en SQL Server, define su esquema relacional compuesto por 4 tablas (`categorias`, `clientes`, `productos`, `ventas`) con sus claves primarias y foráneas, e inserta los registros iniciales para el análisis.
* **`modulo-4/m4_consultas_negocio.sql`**  
  Consultas analíticas orientadas a responder preguntas de negocio utilizando agregaciones (`GROUP BY`), filtros sobre grupos (`HAVING`), lógica condicional (`CASE`) y expresiones de tabla comunes (`WITH` / CTEs).
* **`modulo-5/m5_consultas_joins.sql`**  
  Consultas relacionales avanzadas combinando múltiples tablas mediante `INNER JOIN`, `LEFT JOIN` y consolidación de resultados con `UNION ALL`.
* **`modulo-6/Pipeline_ETL_Abalos_Joaquin.pbix`**  
  Archivo de Power BI Desktop enfocado en la etapa de extracción, transformación y carga (ETL) utilizando **Power Query** para la limpieza, normalización y tipado de datos.
* **`modulo-8/Abalos_Joaquin_Checkpoint2.pbix`**  
  Modelo de datos en estrella en Power BI Desktop: 4 relaciones 1:N con dirección única (Dim_Clientes, Dim_Productos, Dim_Categorias y Dim_Fechas hacia Fact_Ventas), la tabla calendario **Dim_Fechas** y la tabla **_Medidas** con 5 medidas **DAX**: Total Ventas, Ventas Online, Ventas YTD, Ventas LY y % Crecimiento Anual. Incluye la página *Validación* con una matriz para comprobar los resultados.

---

## 🚀 Cómo ejecutar los scripts SQL

Para reproducir la base de datos y probar las consultas en tu entorno local, seguí estos pasos:

### 1. Requisitos previos
* Tener instalado **SQL Server 2025** (en ejecución) y **SQL Server Management Studio (SSMS)**.

### 2. Creación de la base de datos (`Ventas_Tech_DB`)
1. Abrí **SSMS** y conectate a tu instancia local de SQL Server.
2. Creá la base vacía, **una sola vez**, en una consulta nueva:
   ```sql
   CREATE DATABASE Ventas_Tech_DB;
   ```
   (El script del módulo 3 no crea la base: empieza con `USE Ventas_Tech_DB;`.)
3. Abrí el archivo `modulo-3/ventas_tech_db.sql` (`Archivo > Abrir > Archivo...` o `Ctrl + O`).
4. Presioná **`F5`** (o hacé clic en **Ejecutar**) para crear las 4 tablas y cargar los datos iniciales. El script se puede correr varias veces: primero borra las tablas si ya existen.
5. Al final se ejecutan 4 consultas de validación que tienen que devolver 4, 5, 6 y 10 filas.

### 3. Ejecución de consultas de análisis
1. Abrí `modulo-4/m4_consultas_negocio.sql` o `modulo-5/m5_consultas_joins.sql` en SSMS.
2. Asegurate de tener seleccionada la base **`Ventas_Tech_DB`** en el menú desplegable de bases de datos disponible (o ejecutá `USE Ventas_Tech_DB;` al inicio).
3. Seleccioná el bloque de consulta que quieras analizar y presioná **`F5`** para visualizar los resultados.

---

## 📈 Visualización de los proyectos de Power BI

Para explorar los archivos `.pbix` de los módulos 6 y 8:
1. Descargá el archivo correspondiente (`Pipeline_ETL_Abalos_Joaquin.pbix` o `Abalos_Joaquin_Checkpoint2.pbix`).
2. Abrilo con **Power BI Desktop**.
3. Los dos archivos se conectan al Excel del curso **`Pipeline_ETL_Dataset.xlsx`** (no a SQL Server). Si querés actualizar los datos, guardá ese Excel en tu compu y cambiá la ruta en *Transformar datos > Configuración de origen de datos*.

---

## 👤 Autor

**Joaquín Abalos** — Estudiante de Data Analytics
