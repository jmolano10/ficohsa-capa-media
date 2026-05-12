# Comparativa de Regiones — ConsultaCobranzasH2H

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 / NI01 |
|---------|-----------------|------------------|-------------|
| **Endpoint OSB** | `/MiddlewareHostToHost/OperationsAndExecution/Payments/CobranzasH2H` (operación `consulta`) | Mismo endpoint | Mismo endpoint |
| **Estado** | Implementado | Parcial (solo parametrización) | No implementado |
| **Base de Datos — Valida Servicio Regional** | MDW (SP: ValidaServicioRegional) | MDW (SP: ValidaServicioRegional) | MDW (SP: ValidaServicioRegional) |
| **Base de Datos — Valida Acceso H2H** | INTFC (SP: validaAccesoH2H) | INTFC (SP: validaAccesoH2H) | INTFC (SP: validaAccesoH2H) |
| **Base de Datos — Consulta Peticiones** | ABKHN (SP: consultaPeticionesDisponiblesH2H) | No encontrado | No encontrado |
| **Base de Datos — Consulta Convenios** | INTFC (SP: consultaConveniosH2H) | No encontrado | No encontrado |
| **Base de Datos — Actualiza Peticiones** | ABKHN (SP: actualizaPeticionesDisponiblesH2H) | No encontrado | No encontrado |
| **Servicio de Consulta** | SJS/sjConsultaCobranzasH2H (Split-Join) | No encontrado | No encontrado |
| **Parámetro MAXAGREEMENTS** | `FICBCO0244.MAXAGREEMENTS` | `FICBCO0244.MAXAGREEMENTS.GT` | No encontrado |
| **Valor por defecto MAXAGREEMENTS** | 10 | 10 | N/A |
| **Transformaciones clave** | consultaConveniosH2HIn.xq, sjConsultaRecaudoH2HIn.xq, sjConsultaRecaudoH2HOut.xq | N/A | N/A |
| **Campos diferenciadores** | Todos los campos del XSD | N/A | N/A |
| **Errores/Excepciones** | FICBCO0258 (mapeo de errores), MW-0008 (no implementado en default) | MW-0008 (SERVICE NOT IMPLEMENTED) | MW-0008 (SERVICE NOT IMPLEMENTED) |
| **Timeouts/Retrys** | No configurados explícitamente | N/A | N/A |
| **Dependencias internas** | validaServicioRegional, validaAccesoH2H, obtenerParametrizacion, consultaPeticionesDisponiblesH2H, consultaConveniosH2H, sjConsultaCobranzasH2H, actualizaPeticionesDisponiblesH2H, mapeoErrores | validaServicioRegional, validaAccesoH2H | validaServicioRegional |
| **Bitácora** | registrarBitacoraH2H (REQ/RSP en proxy padre) | registrarBitacoraH2H (REQ/RSP en proxy padre) | registrarBitacoraH2H (REQ/RSP en proxy padre) |
| **ID Proxy (ServiceId)** | FICBCO0258 | FICBCO0258 | FICBCO0258 |

---

## Detalle por Región

### HN01 — Honduras (Implementado)

**Flujo completo:**

1. **CobranzasH2H** (proxy padre): Autenticación custom-token, registro de bitácora REQ, enrutamiento por operación `consulta` → ConsultaCobranzasH2H
2. **ValidacionesGenerales_request**:
   - Validación XSD del body contra `cobranzasH2HTypes.xsd`
   - Validación de servicio regional (SP: ValidaServicioRegional, serviceId=FICBCO0258)
   - Validación de acceso H2H (SP: validaAccesoH2H)
   - Obtención de parametrización MAXAGREEMENTS
3. **Branch HN01**:
   - Validación de número de solicitudes vs MAXAGREEMENTS
   - Consulta de peticiones disponibles por día (SP: consultaPeticionesDisponiblesH2H)
   - Consulta de convenios (SP: consultaConveniosH2H)
   - Consulta de cobranzas vía Split-Join (sjConsultaCobranzasH2H)
   - Actualización de peticiones disponibles (SP: actualizaPeticionesDisponiblesH2H)
4. **Respuesta**: Mapeo de salida con sjConsultaRecaudoH2HOut.xq
5. **CobranzasH2H** (proxy padre): Registro de bitácora RSP

**Políticas de seguridad:**
- Custom-token-authentication en proxy padre (UserName/Password del header SOAP)

**Manejo de errores:**
- Error handler global con mapeo de errores (FICBCO0258)
- Error handler específico para ActualizaPeticionesDisponibles (resume, no bloquea)
- Error handler para ObtenerParametrizacion (usa default 10, resume)

### GT01 — Guatemala (Parcial)

- La parametrización de MAXAGREEMENTS usa `FICBCO0244.MAXAGREEMENTS.GT`
- Sin embargo, en el branch de regionalización del proxy ConsultaCobranzasH2H, solo existe branch para `HN01`
- GT01 cae al **default-branch** que retorna error `MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY`
- Las validaciones generales (servicio regional, acceso H2H) sí se ejecutan antes del branch

### PA01 / NI01 — Panamá / Nicaragua (No implementado)

- Caen directamente al default-branch con error `MW-0008`
- No tienen parametrización específica de MAXAGREEMENTS
- Las validaciones generales se ejecutan normalmente
