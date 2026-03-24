# Resumen Ejecutivo - ConsultaRemesaCB

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)
7. [Mapeo de Errores](07-MapeoErrores.md)

---

## 1. Propósito de la Funcionalidad

**ConsultaRemesaCB** es un servicio proxy de Oracle Service Bus (OSB) que actúa como punto de entrada para la consulta de remesas desde aplicaciones de Corresponsalía Bancaria (CB). Este servicio:

- Recibe solicitudes de consulta de remesas con credenciales cifradas
- Valida el corresponsal bancario autorizado
- Descifra credenciales de usuario (LOGINUSER/LOGINPASS) usando operaciones criptográficas
- Delega la consulta al servicio interno `ConsultaRemesas`
- Registra límites transaccionales para control de remesas consultadas

## 2. Entradas y Salidas Principales

### Entrada (Request)

**Endpoint**: `/Middleware/OperationsAndExecution/Payments/ConsultaRemesaCB`

**Protocolo**: SOAP 1.1

**Header**:
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>string</DestinationBank>
    </Region>
    <BankingCorrespondent>
        <Id>string</Id>
    </BankingCorrespondent>
</RequestHeader>
```

**Body**:
```xml
<consultaRemesas>
    <REMITTANCE_ID>string</REMITTANCE_ID>
    <REMITTER_FIRSTNAME>string</REMITTER_FIRSTNAME>
    <REMITTER_MIDDLENAME>string</REMITTER_MIDDLENAME>
    <REMITTER_FIRSTSURNAME>string</REMITTER_FIRSTSURNAME>
    <REMITTER_SECONDSURNAME>string</REMITTER_SECONDSURNAME>
    <BENEFICIARY_FIRSTNAME>string</BENEFICIARY_FIRSTNAME>
    <BENEFICIARY_MIDDLENAME>string</BENEFICIARY_MIDDLENAME>
    <BENEFICIARY_FIRSTSURNAME>string</BENEFICIARY_FIRSTSURNAME>
    <BENEFICIARY_SECONDSURNAME>string</BENEFICIARY_SECONDSURNAME>
    <CORRESPONSAL_BRANCHCODE>string</CORRESPONSAL_BRANCHCODE>
    <ADDITIONAL_INFO>
        <INFO>
            <NAME>ID</NAME>
            <VALUE>string</VALUE>
        </INFO>
        <INFO>
            <NAME>LOGINUSER</NAME>
            <VALUE>encrypted_string</VALUE>
        </INFO>
        <INFO>
            <NAME>LOGINPASS</NAME>
            <VALUE>encrypted_string</VALUE>
        </INFO>
    </ADDITIONAL_INFO>
</consultaRemesas>
```

### Salida (Response)

**Header**:
```xml
<ResponseHeader>
    <successIndicator>SUCCESS|ERROR</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

**Body**:
```xml
<consultaRemesasResponse>
    <consultaRemesasResponseType>
        <consultaRemesasResponseRecordType>
            <REMITTANCE_ID>string</REMITTANCE_ID>
            <REMITTER_ID>string</REMITTER_ID>
            <REMITTER_NAME>string</REMITTER_NAME>
            <BENEFICIARY_NAME>string</BENEFICIARY_NAME>
            <BRANCH_NAME>string</BRANCH_NAME>
            <PAYMENT_DATE>string</PAYMENT_DATE>
            <CURRENCY>string</CURRENCY>
            <EXCHANGE_RATE>decimal</EXCHANGE_RATE>
            <REMITTANCE_STATUS>DISPONIBLE|PAGADA</REMITTANCE_STATUS>
            <REMITTANCE_AMOUNT>decimal</REMITTANCE_AMOUNT>
            <REMITTANCE_SOURCE_AMOUNT>decimal</REMITTANCE_SOURCE_AMOUNT>
            <ORIGIN_COUNTRY>string</ORIGIN_COUNTRY>
        </consultaRemesasResponseRecordType>
    </consultaRemesasResponseType>
</consultaRemesasResponse>
```

## 3. Sistemas/Servicios OSB Involucrados

### Servicios Proxy
- **ConsultaRemesaCB** (Punto de entrada CB)
- **ConsultaRemesas** (Servicio interno principal)
- **OperacionesCriptograficas** (Descifrado de credenciales)
- **MapeoErrores** (Homologación de errores)
- **EvaluaListasCliente** (Validación de listas restrictivas)

### Business Services - Base de Datos

#### Esquema: ORA_BANK (Middleware)
- **MW_P_OBTENER_TIPO_REMESADORA**: Identifica el tipo de remesadora por clave
- **MW_P_VALIDAR_CORRESPONSAL**: Valida corresponsal bancario autorizado
- **MW_P_VALIDAR_SERVICIO_REGIONAL**: Valida servicio por región (FICBCO0148)
- **MW_P_LIMITE_TRX_REGISTRAR**: Registra límite transaccional

#### Esquema: TERCEROS (Convenios)
- **OSB_K_CONSULTARREMLOCALID.CV_K_DATOS_REMESAS$CONSU_X_ID**: Consulta remesas locales por ID
- **OSB_K_CONSULTARREMFREMID.CV_K_DATOS_REMESAS_POR_PAGADOR**: Consulta Ficohsa Remesas por pagador
- **OSB_K_RECAUDOS_REF_ONLINE.OSB_ARMAR_MENSAJE**: Arma mensaje para enrutador de convenios
- **OSB_K_OBTENER_CAMPOS_REMESAS_REL**: Obtiene campos de relación de remesas

### Business Services - Externos
- **enrutadorConvenios**: Servicio HTTP que consulta remesas ONLINE (Moneygram, Uniteller, BTS, Pacific)
- **sjConsultaRemesaResiliencia**: Servicio de resiliencia para consultas T24

### Tipos de Remesadoras Soportadas
1. **REMESALOCAL**: Remesas locales en tablas FLink o T24
2. **FICOREMESA**: Ficohsa Remesas
3. **ONLINE**: Remesadoras en línea (Moneygram, Uniteller, BTS, Pacific)

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
1. **Dependencia de Cifrado**: El servicio requiere descifrado de credenciales con clave "ONE-TIME-PASSWORD" y algoritmo RSA
2. **Timeout en Enrutador**: El enrutador de convenios puede tener timeouts en consultas a remesadoras externas
3. **Múltiples Remesadoras**: Si una clave existe en múltiples remesadoras, se selecciona por prioridad
4. **Validación de Listas**: Solo aplica para remesadoras ONLINE configuradas en parámetros

### Limitaciones Funcionales
1. **Solo Región HN01**: El servicio solo está implementado para Honduras (HN01)
2. **Consulta por ID**: Solo soporta consulta por REMITTANCE_ID, no por nombre
3. **Estados Limitados**: Solo maneja estados DISPONIBLE y PAGADA
4. **Sin Retry**: No hay mecanismo de reintento en caso de fallo

### Limitaciones de Seguridad
1. **Validación de Corresponsal**: Requiere validación previa del corresponsal con tipo de transacción "9"
2. **Permisos por Usuario**: Los usuarios tienen permisos específicos por tipo de remesadora (parámetro REMITALLOW)
3. **Evaluación de Listas**: Opcional según configuración del usuario (parámetro CHECKLISTS)

## 5. Métricas o SLAs

### Timeouts Configurados
- **consultarCorresponsalB**: Sin timeout explícito (default 30s retry)
- **ObtenerTipoRemesadora**: Sin timeout explícito
- **armarMensajeRecaudo**: 60 segundos (QueryTimeout)
- **enrutadorConvenios**: Sin timeout (0 = ilimitado)
- **sjConsultaRemesaResiliencia**: Sin timeout (0 = ilimitado)

### Retry Policies
- **armarMensajeRecaudo**: 1 retry con intervalo de 30 segundos
- **Otros servicios DB**: 0 retries

### Logging
- **Nivel de Log**: DEBUG habilitado en ConsultaRemesaCB
- **Reporting**: Habilitado para métricas
- **SLA Alerting**: Habilitado con nivel NORMAL

## 6. Flujo General de Procesamiento

1. **Validación de Entrada**: Valida esquema XML del request
2. **Validación de Corresponsal**: Verifica que el corresponsal esté autorizado para transacción tipo "9"
3. **Descifrado de Credenciales**: Si existen LOGINUSER/LOGINPASS, los descifra usando RSA
4. **Validación Regional**: Valida servicio FICBCO0148 para región HN01
5. **Obtención de Parámetros**: Obtiene configuración del usuario (REMITALLOW, IDPAYERGUSER, CHECKLISTS)
6. **Identificación de Remesadora**: Llama a MW_P_OBTENER_TIPO_REMESADORA
7. **Enrutamiento por Tipo**:
   - **REMESALOCAL**: Consulta en FLink o T24
   - **FICOREMESA**: Consulta en tablas de Ficohsa Remesas
   - **ONLINE**: Consulta múltiples remesadoras por prioridad
8. **Evaluación de Listas**: Si aplica, valida contra listas restrictivas
9. **Registro de Relación**: Inserta registro de consulta-pago si estado es DISPONIBLE
10. **Registro de Límite**: Registra límite transaccional con monto y tasa de cambio
11. **Respuesta**: Retorna datos de la remesa o error

## 7. Consideraciones de Migración

### Componentes a Migrar
- Lógica de descifrado de credenciales
- Validación de corresponsal bancario
- Enrutamiento por tipo de remesadora
- Integración con múltiples fuentes de datos (FLink, T24, Enrutador)
- Registro de límites transaccionales

### Dependencias Críticas
- Servicio de criptografía (OperacionesCriptograficas)
- Base de datos Middleware (ORA_BANK)
- Base de datos Convenios (TERCEROS)
- Enrutador de convenios (HTTP externo)
- Servicio T24 (para remesas locales)

### Datos de Configuración
- Parámetros por usuario: T24C070.{USERNAME}.REMITALLOW, IDPAYERGUSER, CHECKLISTS, CHECKREMITTERID
- Parámetros por tipo de remesa: T24C070.{TIPO}.REMITSOURCE (DOLEX, RIA, FICOEXP, GROUPEX, REMTRAS, TRANSFAST, SIGUE, GIROSOL)
- Credenciales LDAP: Middleware/Security/{USERNAME}
- Configuración de remesadoras por tipo y prioridad

## 8. Tipos de Remesas Locales Identificadas

El sistema identifica automáticamente el tipo de remesa local basado en prefijos de la clave:

| Prefijo | Tipo | Descripción |
|---------|------|-------------|
| LX | DOLEX | Remesas Dolex |
| RF | RIA | Remesas RIA |
| FCX, FTL, FOR, FNJ, TAM, CHA, BRX, HEM, HST, PLF, GNA, NBW, NWO, FNW | FICOEXP | Ficohsa Express |
| GPX | GROUPEX | Group Express |
| RT, US, GMT, IDT | REMTRAS | Remesas y Transferencias |
| TF | TRANSFAST | TransFast |
| SIG | SIGUE | Sigue |
| GS | GIROSOL | Girosol |
| Otros | NO IDENTIFICADA | Tipo no reconocido |

## 9. Configuración de Seguridad

### Credenciales LDAP
- **Ruta**: `Middleware/Security/{USERNAME}` (en mayúsculas)
- **Fallback**: Credenciales del header si LDAP no disponible
- **Uso**: Conexiones a T24 para remesas locales

### Cifrado RSA
- **Algoritmo**: RSA
- **Clave**: "ONE-TIME-PASSWORD"
- **Campos**: LOGINUSER y LOGINPASS en ADDITIONAL_INFO
- **Servicio**: OperacionesCriptograficas.cifrarDatos
