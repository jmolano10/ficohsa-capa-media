# Especificación Funcional de la API: Reward Points Account Admin - Product

## 1. Control de Cambios del Documento
| Fecha       | Motivo                 | Realizado por            |
|-------------|------------------------|---------------------------|
| 26/11/2025  | Creacion del documento      | Harold Rene Baron Franco|

[[_TOC_]]


## 2. Clasificación de la API
| Item | Motivo |
|-|-|
| Nombre de la API | RewardPointsAccountAdmin-Product_v1.0|
| Clasificación de la API | Product |
| Version del Servicio | 1.0.0 |
| Basepath/Namespace |/crss-prdct-ops/reward-points-accnt-admin/v1 |
| Contrato ||


## 3. Descripción de la API

API que permite Permite la eliminación de tasas de cambio de puntos configuradas previamente en los diferentes países.


### 3.1. Métodos de la API

- ### 3.1.1. Método 1 - POST: /crss-prdct-ops/reward-points-accnt-admin/v1/{reference}/delete

  - Proporcionar información detallada de tarjetas a los canales digitales y sistemas que requieran validar o mostrar datos de tarjetas de débito.


En la siguiente tabla se describe el mensaje de solicitud, mensaje de respuesta y excepciones de la operación del servicio:

- #### 3.1.1.1. Petición

| Nombre del Campo | Descripción                          | Dominio de Valores | Tipo de Dato  | Cardinalidad | Dato Obligatorio | Longitud | Longitud Mínima | Cifras Enteras | Observaciones |
|------------------|--------------------------------------|---------------------|--------|--------------|------------------|----------|------------------|----------------|---------------|
|  reference | Identificador de la promoción a eliminar |-| string |1..1 | Si |1|-|-| Corresponde al  path Parameter |
| Authorization|Token de autenticación en formato Bearer <token> (normalmente JWT u otro mecanismo OAuth2)| N/A | string | 1..1 | Sí | N/A | N/A | N/A |Corresponde al header |
| Correlation-Id| Identificador único de la transacción para trazabilidad extremo a extremo. Se propaga en toda la cadena de llamadas (Debe ser el mismo en la respuesta). Formato UUID.Este campo puede ir vacío, y en este caso, desde la API se debe generar para tener trazabilidad interna del flujo de la API a nivel de petición y respuesta| N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
| Source-Bank|Código del banco origen de la petición. Podría validarse contra el token para evitar suplantaciones. Ejemplo: HN01, GT01| N/A | string | 1..1 | Si | N/A | N/A | N/A | Corresponde al header
| Destination-Bank|Código del banco destino de la operación. Ejemplo: HN01, GT01 | N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
| Application-Id|Identificador de la Aplicación que consume la API. Podría derivarse del token. | N/A | string | 1..1 | Si | N/A | N/A | N/A | Corresponde al header |
| Application-User|Usuario de la aplicación consumidora que está ejecutando el servicio| N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
| Caller-Service|En caso de APIs de experiencia o composición se usaría, para identificar la API que compone a las APIs de Producto| N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
| Channel|Canal de interacción de la petición. Ejemplo: web, mobile, partner, atm, branch, ivr, etc.| N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
| Transaction-Date|Fecha de la transacción. Formato DateTime. YYYY-MM-DDTHH:MI:SS.| N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
| Accept-Language|Idioma preferido para mensajes y errores, usando código ISO 639-1 (es para español, en para inglés)| N/A | string | 0..1 | No | N/A | N/A | N/A | Corresponde al header |
---
    
### 3.1.1.2. Respuesta

| Nombre del Campo | Descripción | Dominio de Valores | Tipo de Dato | Cardinalidad | Dato Obligatorio | Longitud | Longitud Mínima | Cifras Enteras | Observaciones |
|------------------|-------------|---------------------|------|--------------|------------------|----------|------------------|----------------|----------------|
|-| Devuelve Sucess o Error |-| - | - | - |-|-|-|-|
---

- #### 3.1.1.3. Tabla de Excepciones


##### 3.1.1.3.1.  Excepciones de Negocio

| Código HTTP | Descripción HTTP | Mensaje Excepción | Observación |
|-------------|-------------------|-------------------|-------------|
| 400 | Bad Request | Los parámetros o formato son inválidos | - |
| 401| Unauthorized |Cliente no autenticado o credenciales inválidas | - |
| 403| Forbidden | Cliente autenticado pero sin permisos | - |
| 404| Not Found | Recurso solicitado no existe | - |
| 409| Conflict | Conflicto de estado | - |
| 422| Unprocessable Entity | Datos válidos en formato pero con errores de negocio |-|
| 423| Locked | El recurso está temporalmente bloqueado | - |
| 429| Too Many Requests | Error interno del servidor | - |
| 500| Internal Server Error | Error inesperado en el servicio | -|
| 502| Bad Gateway | Falla de un servicio intermedio/gateway | - |
| 503| Service Unavailable | Servicio temporalmente no disponible | - |
| 504| Gateway Timeout| Tiempo de espera excedido en servicio dependiente | -|

  
##### 3.1.1.3.2. Excepciones Técnicas Internas

| Código HTTP | Descripción HTTP | Mensaje Excepción | Observación |
|-------------|-------------------|-------------------|-------------|
| 400 | Integration Bad Request| Los parámetros o formato son inválidos|Cuando el error ocurre antes de ejecutar la lógica de negocio, debido a problemas en la solicitud entre componentes internos de la capa de integración. Es decir, la API no puede procesar la solicitud porque los parámetros, encabezados o formato no cumplen el contrato esperado|
| 500 | Internal Server Error | Error inesperado en el servicio |Cuando la falla proviene de la propia plataforma de integración o de un error inesperado no controlado Se usa cuando no existe un manejo predecible o no hay contexto suficiente para un código más específico  |
| 504 | Gateway Timeout | Tiempo de espera excedido en servicio dependiente | Cuando la capa de integración actúa como cliente de un backend o microservicio y no recibe respuesta en el tiempo configurado, lo que refleja problemas de latencia o disponibilidad en la cadena de servicios |

Recordar que las excepciones pueden venir también en ingles, esto va a depender del campo del Header Accept-Language. En caso de necesitarse se encuentran en el catálogo de excepciones (MappingExceptionsCatalog)


- #### 3.1.1.4. Condiciones de Uso

| Condición| Descripción |
|--------|-------------|
| *Enrutamiento Regional*  | *Funcionalidad usada en Honduras, Panama, Nicaragua  y Guatemala* |
| *Validaciones*  | *reference debe tener al menos 1 carácter* |
|                 | *Se valida el servicio regional con serviceId "FICBCO0275"* |
| *Manejo de Errores*  | *Se aplica mapeo de errores mediante el manejador de  errores definido en el documento  **Lineamientos de Diseño y Gobernanza de la Arquitectura de Integración*** |
| *Arquitectura Multi-Core:*  | *El servicio soporta múltiples sistemas core (ABK, ABKGT, ABKPA, PXYNIC) según el país* |
| *Datos Relevantes*  | *El servicio NO requiere reversos (operación de eliminación)* |
|                     | *Servicio crítico para gestión de programas de puntos y promociones* |
|                     | *Permite eliminar factores de canje previamente configurados* |
|                     | *La eliminación es permanente y no reversible* |
|                     | *Cada país tiene su propia base de datos y stored procedure* |
|                     | *El reference debe existir en la base de datos para poder eliminarse* |
| *Canales que utilizan la capacidad*  | *SALESFORCE* |