# Listado de Ficheros - EliminarFactorCanje

## Proxy Services

### Proxy Principal (Enrutamiento Dinámico)
```
Middleware/v2/ProxyServices/EliminarFactorCanje.proxy
```

### Proxies Regionales
```
Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy
Middleware/v2/ProxyServices/EliminarFactorCanjeGT.proxy
Middleware/v2/ProxyServices/EliminarFactorCanjePA.proxy
Middleware/v2/ProxyServices/EliminarFactorCanjeNI.proxy
```

---

## Business Services

### Honduras (HN01)
```
Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd
```

### Guatemala (GT01)
```
Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd
```

### Panamá (PA01)
```
Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd
```

### Nicaragua (NI01)
```
Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd
```

---

## Transformaciones XQuery

### Transformaciones Regionales
```
Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeHNIn.xq
Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeGTIn.xq
Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjePAIn.xq
Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeIn.xq
```

**Nota**: Nicaragua usa `eliminarFactorCanjeIn.xq` (sin sufijo regional).

---

## WSDL y XSD

### WSDL del Proxy Service
```
Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS.wsdl
```

### XSD de Tipos de Negocio
```
Middleware/v2/Resources/GestionPuntosTarjetas/xsd/gestionPuntosTarjetasTypes.xsd
```

### XSD de Headers
```
Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd
```

---

## Servicios de Soporte

### Consulta de Ruta Regional
```
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/jca/consultaRutaRegional_db.jca
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/wsdl/consultaRutaRegional_db.wsdl
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/xsd/consultaRutaRegional_sp.xsd
```

### Transformaciones de Consulta Regional
```
Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq
Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq
```

### Mapeo de Errores
```
Middleware/v2/ProxyServices/MapeoErrores.proxy
Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq
Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq
```

---

## Artefactos de Despliegue (JAR)

### Despliegues de Producción
```
JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/mwomnicanal_EliminarFactorCanje.jar
JAR/2020.8.2.0/PG-2791/Produccion/Paquete_III/EliminarFactorCanje_GT.jar
JAR/2019.10.1.5/PG-1208/OSB/31.TA-378-Agregar_Eliminar_Factor_Canje_PA-GT.jar
```

### Despliegues de QA
```
JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/mwomniqa_EliminarFactorCanje.jar
JAR/2020.8.2.0/PG-2791/QA/Paquete_III/EliminarFactorCanje_GT.jar
```

---

## Resumen por Tipo de Archivo

### Proxy Services (5 archivos)
- 1 proxy principal con enrutamiento dinámico
- 4 proxies regionales (HN, GT, PA, NI)

### Business Services (20 archivos)
- 4 archivos .biz (configuración de servicio)
- 4 archivos .jca (configuración de adaptador JCA)
- 8 archivos .wsdl (2 por región: servicio y DB)
- 4 archivos .xsd (definición de parámetros SP)

### Transformaciones XQuery (4 archivos)
- 1 por región (HN, GT, PA, NI)

### WSDL y XSD Compartidos (3 archivos)
- 1 WSDL del proxy service
- 1 XSD de tipos de negocio
- 1 XSD de headers

### Servicios de Soporte (7+ archivos)
- Consulta de ruta regional (4 archivos)
- Transformaciones generales (2 archivos)
- Mapeo de errores (3+ archivos)

### Artefactos de Despliegue (5+ archivos JAR)
- Múltiples versiones y ambientes

---

## Total de Archivos Identificados

| Categoría | Cantidad |
|-----------|----------|
| Proxy Services | 5 |
| Business Services | 20 |
| Transformaciones XQuery | 4 |
| WSDL/XSD Compartidos | 3 |
| Servicios de Soporte | 7+ |
| Artefactos JAR | 5+ |
| **TOTAL** | **44+** |

---

## Archivos por Región

### Honduras (HN01)
```
Proxy:
- Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy

Business Service:
- Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
- Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
- Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
- Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
- Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd

Transformación:
- Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeHNIn.xq

JAR:
- JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/mwomnicanal_EliminarFactorCanje.jar
- JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/mwomniqa_EliminarFactorCanje.jar
```

### Guatemala (GT01)
```
Proxy:
- Middleware/v2/ProxyServices/EliminarFactorCanjeGT.proxy

Business Service:
- Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
- Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
- Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
- Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
- Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd

Transformación:
- Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeGTIn.xq

JAR:
- JAR/2020.8.2.0/PG-2791/Produccion/Paquete_III/EliminarFactorCanje_GT.jar
- JAR/2020.8.2.0/PG-2791/QA/Paquete_III/EliminarFactorCanje_GT.jar
- JAR/2019.10.1.5/PG-1208/OSB/31.TA-378-Agregar_Eliminar_Factor_Canje_PA-GT.jar
```

### Panamá (PA01)
```
Proxy:
- Middleware/v2/ProxyServices/EliminarFactorCanjePA.proxy

Business Service:
- Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
- Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
- Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
- Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
- Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd

Transformación:
- Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjePAIn.xq

JAR:
- JAR/2019.10.1.5/PG-1208/OSB/31.TA-378-Agregar_Eliminar_Factor_Canje_PA-GT.jar
```

### Nicaragua (NI01)
```
Proxy:
- Middleware/v2/ProxyServices/EliminarFactorCanjeNI.proxy

Business Service:
- Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db.biz
- Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/jca/eliminarFactorCanje_db.jca
- Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/wsdl/eliminarFactorCanje.wsdl
- Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/wsdl/eliminarFactorCanje_db.wsdl
- Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/xsd/eliminarFactorCanje_sp.xsd

Transformación:
- Middleware/v2/Resources/EliminarFactorCanje/xq/eliminarFactorCanjeIn.xq

JAR:
- (No se encontraron JARs específicos para NI en la búsqueda)
```

---

## Archivos Compartidos entre Regiones

### WSDL y XSD
```
Middleware/v2/Resources/EliminarFactorCanje/wsdl/eliminarFactorCanjePS.wsdl
Middleware/v2/Resources/GestionPuntosTarjetas/xsd/gestionPuntosTarjetasTypes.xsd
Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd
```

### Proxy Principal
```
Middleware/v2/ProxyServices/EliminarFactorCanje.proxy
```

### Servicios de Soporte
```
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/jca/consultaRutaRegional_db.jca
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/wsdl/consultaRutaRegional_db.wsdl
Middleware/v2/BusinessServices/MDW/consultaRutaRegional/xsd/consultaRutaRegional_sp.xsd
Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq
Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq
Middleware/v2/ProxyServices/MapeoErrores.proxy
Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq
Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq
```

---

## Archivos No Encontrados (Posibles)

Los siguientes archivos son referenciados pero no fueron encontrados en la búsqueda:

### Configuraciones de Conexión
```
(Archivos de configuración de JNDI para conexiones DB)
- ConnectionProxyAbanksHN
- ConnectionProxyAbanksGT
- ConnectionProxyAbanksPA
- ConnectionProxyNI
```

### Políticas de Seguridad
```
(Archivos de políticas WS-Security si existen)
```

### Tests
```
(Archivos de pruebas unitarias o de integración si existen)
```

---

## Notas Importantes

1. **Convención de Nombres**: 
   - HN usa carpeta `ABK` (sin sufijo regional)
   - GT y PA usan `ABKGT` y `ABKPA` respectivamente
   - NI usa `PXYNIC` (convención diferente)

2. **XQuery Sin Sufijo**: 
   - Nicaragua usa `eliminarFactorCanjeIn.xq` sin sufijo "NI"

3. **Versiones JAR**: 
   - Múltiples versiones indican evolución del servicio
   - Tickets: PG-5293, PG-2791, PG-1208, TA-378

4. **Ambientes**: 
   - Se detectaron despliegues en PRD (Producción) y QA

5. **Dependencias Críticas**:
   - Todos los proxies regionales dependen de `gestionPuntosTarjetasTypes.xsd`
   - El proxy principal depende de `consultaRutaRegional_db` y `MapeoErrores`

---

## Recomendaciones para Migración

1. **Verificar Existencia**: Confirmar que todos los archivos listados existen en el ambiente objetivo.

2. **Validar Dependencias**: Asegurar que los servicios de soporte (`consultaRutaRegional_db`, `MapeoErrores`) están disponibles.

3. **Configurar Conexiones**: Validar que las conexiones JNDI están configuradas correctamente en el servidor objetivo.

4. **Migrar en Orden**:
   - Primero: Archivos compartidos (WSDL, XSD)
   - Segundo: Servicios de soporte
   - Tercero: Business Services por región
   - Cuarto: Transformaciones XQuery
   - Quinto: Proxies regionales
   - Sexto: Proxy principal

5. **Testing por Región**: Probar cada región independientemente antes de habilitar el enrutamiento dinámico.

6. **Backup de JARs**: Mantener copias de los JARs actuales para rollback si es necesario.
