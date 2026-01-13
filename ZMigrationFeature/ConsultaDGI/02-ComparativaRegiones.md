# Comparación entre Regiones - ConsultaDGI

## Tabla de Comparación Regional

| Aspecto | NI01 (Nicaragua) | Otras Regiones (Default) |
|---------|------------------|---------------------------|
| **Endpoint OSB** | CTS COBIS Impuestos | No implementado |
| **Nombre de Base de Datos** | COBIS CTS | N/A |
| **Esquemas** | COBIS Impuestos Schema | N/A |
| **Store Procedure** | OpConsultaDGI | N/A |
| **Nombre de Conexión** | CTS impuesto | N/A |
| **Transformaciones clave** | consultaDGIIn.xq | N/A |
| **Campos diferenciadores** | contextoTransaccional | Error MW-0008 |
| **Errores/Excepciones** | COBIS Error Structure | SERVICE NOT IMPLEMENTED |
| **Timeouts/Retrys** | timeout=0, retry=0 | N/A |
| **Dependencias internas** | Parametrización OSB | N/A |
| **Parametrización externa** | Sí (TIPOCONSULTADGI, CODIGOBANCODGI) | No |
| **Validación esquema** | services.xsd (CTS) | consultaDGITypes.xsd |
| **Contexto COBIS** | Obligatorio | N/A |

## Detalles por Región

### NI01 (Nicaragua - DGI)

**Características específicas:**
- Utiliza servicio CTS COBIS Impuestos como backend
- Requiere parametrización externa obligatoria
- Implementa contexto transaccional específico de COBIS
- Maneja consultas de BIT (Boleta de Ingreso Tributario)
- Transformación completa de datos fiscales

**Endpoint de conexión:**
- Business Service: `Middleware/v2/BusinessServices/CTS/impuesto/biz/impuesto`
- Operación: `OpConsultaDGI`
- Endpoint: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`

**Parametrización requerida:**
- `FICBCO0256.TIPOCONSULTADGI`: Tipo de consulta DGI
- `FICBCO0256.CODIGOBANCODGI`: Código del banco para DGI

**Validaciones específicas:**
- Validación de parametrización antes del procesamiento
- Validación de esquema CTS antes del envío
- Validación XSD de entrada obligatoria

**Estructura de request específica:**
```xml
<contextoTransaccional>
    <codCanalOriginador>1</codCanalOriginador>
</contextoTransaccional>
<consultaBIT>
    <valRUC>{RUC}</valRUC>
    <tipoConsulta>{parámetro}</tipoConsulta>
    <valCodigoBanco>{parámetro}</valCodigoBanco>
    <bit>{BILL_NUMBER}</bit>
</consultaBIT>
```

**Mapeo de datos completo:**
- Entrada: RUC + BILL_NUMBER → valRUC + bit
- Salida: 9 campos de respuesta fiscal
- Transformación de fechas con ajuste de timezone
- Manejo de códigos de respuesta COBIS

### Otras Regiones (Default)

**Características específicas:**
- No hay implementación funcional
- Retorna error estándar MW-0008
- Solo ejecuta validaciones generales
- Pipeline vacío sin procesamiento

**Comportamiento:**
- Validación XSD de entrada
- Validación de servicio regional
- Error inmediato: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

**Flujo simplificado:**
1. Validación XSD → OK
2. Validación regional → OK  
3. Enrutamiento → Default
4. Error MW-0008 → Cliente

## Diferencias Clave de Implementación

### Cobertura Funcional
- **NI01**: Implementación completa con CTS COBIS
- **Otras**: Solo mensaje de error

### Dependencias Externas
- **NI01**: CTS COBIS + Parametrización OSB
- **Otras**: Ninguna

### Complejidad de Procesamiento
- **NI01**: 
  - 2 etapas: Parametrización + Consulta CTS
  - Validaciones múltiples
  - Transformaciones complejas
- **Otras**: 
  - 1 etapa: Error directo
  - Sin transformaciones

### Manejo de Errores
- **NI01**: 
  - Errores de parametrización
  - Errores CTS COBIS
  - Códigos específicos de DGI
- **Otras**: 
  - Solo error MW-0008
  - Sin manejo específico

### Configuración Requerida
- **NI01**: 
  - 2 parámetros obligatorios
  - Configuración CTS
  - Esquemas COBIS
- **Otras**: 
  - Sin configuración específica
  - Solo validaciones generales

## Regiones Detectadas

Basándose en el análisis del código fuente, se identifican las siguientes regiones:

### Regiones Implementadas
- **NI01**: Nicaragua (implementación completa)

### Regiones No Implementadas
- **HN01**: Honduras (error MW-0008)
- **GT01**: Guatemala (error MW-0008)  
- **PA01**: Panamá (error MW-0008)
- **Cualquier otra región**: Error MW-0008

## Patrón de Enrutamiento

El servicio utiliza un patrón de enrutamiento simple:

```xml
<con:branch-table variable="header">
  <con:xpath>./aut:RequestHeader/Region/SourceBank</con:xpath>
  <con:branch name="NI01">
    <con:operator>equals</con:operator>
    <con:value>'NI01'</con:value>
    <!-- Implementación completa -->
  </con:branch>
  <con:default-branch>
    <!-- Error MW-0008 -->
  </con:default-branch>
</con:branch-table>
```

## Consideraciones para Expansión

### Para implementar en otras regiones se requeriría:

1. **Backend específico**: Conexión a sistema fiscal local
2. **Parametrización**: Configuraciones por país
3. **Transformaciones**: Mapeo de datos específico
4. **Validaciones**: Esquemas y reglas locales
5. **Manejo de errores**: Códigos específicos por región

### Patrón de implementación sugerido:
- Seguir el modelo NI01
- Crear business services específicos
- Implementar transformaciones XQuery
- Configurar parámetros regionales
- Adaptar manejo de errores