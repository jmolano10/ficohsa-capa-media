# Comparativa entre Regiones - ValidaNumeroViajero

## Análisis de Regionalización

**CONCLUSIÓN PRINCIPAL**: La funcionalidad ValidaNumeroViajero **NO presenta diferencias por región**. Es un servicio **transversal y unificado** que opera de manera idéntica independientemente de la región de origen.

## Tabla de Comparación por Región

| Aspecto | Todas las Regiones (HN01, GT01, PA01, NI01) |
|---------|---------------------------------------------|
| **Endpoint OSB** | `/Middleware/CreditCard/Customer/ValidaNumeroViajero` |
| **Nombre de Base de Datos** | ConnectionInterfazSFC |
| **Esquemas** | SALESFORCE |
| **Store Procedure** | SFC_VALIDAR_NUMERO_VIAJERO |
| **Nombre de Conexión a Base de datos** | jca://eis/DB/ConnectionInterfazSFC |
| **Transformaciones clave** | ValidaNumeroViajeroIn.xq, ValidaNumeroViajeroOut.xq |
| **Campos diferenciadores** | Ninguno - Servicio agnóstico a región |
| **Errores/Excepciones** | Manejo estándar: SUCCESS, ERROR |
| **Timeouts/Retrys** | retry-count=0, retry-interval=30s |
| **Dependencias internas** | Stored Procedure SFC_VALIDAR_NUMERO_VIAJERO |
| **Protocolo** | SOAP/HTTPS |
| **Puerto** | 8004 |
| **Autenticación** | Custom token (username/password en header) |
| **Validación** | Esquema XSD validaNumeroViajeroTypes |

## Detalles por Región

### TODAS LAS REGIONES (HN01, GT01, PA01, NI01)

#### Características Comunes
- **Proxy Service**: ValidaNumeroViajero.proxy
- **Business Service**: validaNumeroViajero_db.biz
- **Endpoint**: `/Middleware/CreditCard/Customer/ValidaNumeroViajero`
- **Conexión DB**: ConnectionInterfazSFC
- **Esquema**: SALESFORCE
- **Stored Procedure**: SFC_VALIDAR_NUMERO_VIAJERO

#### Mapeos de Entrada
```xml
<PV_TYPE>{ data($validaNumeroViajero1/Type) }</PV_TYPE>
<PV_NUMERO_VIAJERO>{ data($validaNumeroViajero1/FlyerNumber) }</PV_NUMERO_VIAJERO>
```

#### Mapeos de Salida
```xml
<Result>{ data($PV_RESULT) }</Result>
```

#### Validaciones
- Validación de esquema XSD obligatoria
- Autenticación custom token requerida
- Campos Type y FlyerNumber obligatorios

#### Políticas OSB
- **Seguridad**: Custom token authentication
- **Logging**: Debug level habilitado
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)

#### Handlers de Error
- Manejo centralizado en pipeline de error
- Códigos estándar: SUCCESS, ERROR
- Mensajes descriptivos en ResponseHeader

#### Timeouts y Reintentos
- **Retry Count**: 0 (sin reintentos automáticos)
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

## Justificación de la Unificación

### Razones Técnicas
1. **Base de datos centralizada**: Salesforce es un sistema único y centralizado
2. **Lógica de negocio uniforme**: La validación de números de viajero no varía por región
3. **Stored procedure único**: SFC_VALIDAR_NUMERO_VIAJERO maneja toda la lógica
4. **Sin configuraciones regionales**: No existen parámetros específicos por país

### Razones de Negocio
1. **Programas de lealtad globales**: Los números de viajero frecuente son únicos globalmente
2. **Consistencia de datos**: Evita duplicaciones y conflictos entre regiones
3. **Mantenimiento simplificado**: Un solo punto de mantenimiento
4. **Escalabilidad**: Fácil agregar nuevas regiones sin cambios

## Diferencias Detectadas

**NINGUNA**: No se detectaron diferencias entre regiones en:
- Configuración de servicios
- Lógica de transformación
- Manejo de errores
- Conexiones a base de datos
- Validaciones
- Políticas de seguridad

## Recomendaciones

### Para la Migración
1. **Mantener como servicio único**: No regionalizar
2. **Implementar en una sola instancia**: Accesible desde todas las regiones
3. **Configurar load balancing**: Para alta disponibilidad
4. **Monitoreo centralizado**: Una sola fuente de métricas

### Para Mejoras Futuras
1. **Cache distribuido**: Para mejorar performance global
2. **Métricas por región**: Para análisis de uso
3. **Versionado**: Para evoluciones futuras
4. **Documentación centralizada**: Mantenimiento simplificado

## Conclusión

La funcionalidad ValidaNumeroViajero es un **servicio transversal** que no requiere diferenciación por región. Su diseño actual es óptimo para un despliegue unificado que sirva a todas las regiones desde una implementación común.