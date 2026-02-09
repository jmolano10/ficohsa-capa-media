# Ejemplos de Request/Response y Mapeo de Datos - Nicaragua (NI01)

## Nota Importante

Según el análisis del código fuente, **Nicaragua (NI01) comparte exactamente la misma lógica, transformaciones y mapeos que Honduras (HN01)**.

La única diferencia es el valor del campo `SourceBank` en el header del request, que debe ser `NI01` o cualquier valor que contenga `NI`.

---

## Diferencias Específicas de Nicaragua

### 1. Campo SourceBank
- **Valor:** `NI01` (en lugar de `HN01`)
- **Validación:** Debe contener `NI` para ser reconocido como Nicaragua

### 2. Moneda Principal
- **Moneda:** NIO (Córdoba Nicaragüense)
- **Ejemplo en Response:**
```xml
<CURRENCY>NIO</CURRENCY>
```

### 3. Ejemplo de Request Header
```xml
<aut:RequestHeader>
   <Authentication>
      <UserName>usuario_nicaragua</UserName>
      <Password>password123</Password>
   </Authentication>
   <Region>
      <SourceBank>NI01</SourceBank>
      <DestinationBank>NI01</DestinationBank>
   </Region>
</aut:RequestHeader>
```

---

## Referencia Completa

Para detalles completos de mapeos, transformaciones y reglas de negocio, consultar:
- [03-EjemplosYMapeos-HN.md](03-EjemplosYMapeos-HN.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)

**Endpoint:** `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v11g`

**Moneda:** NIO (Córdoba Nicaragüense)

**Código de País:** NI01

**Zona Horaria:** GMT-6 (Central Standard Time)
