# Ejemplos de Request/Response y Mapeo de Datos - Panamá (PA01)

## Nota Importante

Según el análisis del código fuente, **Panamá (PA01) comparte exactamente la misma lógica, transformaciones y mapeos que Honduras (HN01)**.

La única diferencia es el valor del campo `SourceBank` en el header del request, que debe ser `PA01` o cualquier valor que contenga `PA`.

---

## Diferencias Específicas de Panamá

### 1. Campo SourceBank
- **Valor:** `PA01` (en lugar de `HN01`)
- **Validación:** Debe contener `PA` para ser reconocido como Panamá

### 2. Moneda Principal
- **Moneda:** PAB (Balboa Panameño) o USD (Dólar Estadounidense)
- **Ejemplo en Response:**
```xml
<CURRENCY>PAB</CURRENCY>
<!-- o -->
<CURRENCY>USD</CURRENCY>
```

### 3. Ejemplo de Request Header
```xml
<aut:RequestHeader>
   <Authentication>
      <UserName>usuario_panama</UserName>
      <Password>password123</Password>
   </Authentication>
   <Region>
      <SourceBank>PA01</SourceBank>
      <DestinationBank>PA01</DestinationBank>
   </Region>
</aut:RequestHeader>
```

---

## Referencia Completa

Para detalles completos de mapeos, transformaciones y reglas de negocio, consultar:
- [03-EjemplosYMapeos-HN.md](03-EjemplosYMapeos-HN.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)

**Endpoint:** `https://mwservices.gfficohsa.hn:8020/regional/massivePayment/soap/getBatchStatus/v11g`

**Moneda:** PAB (Balboa Panameño) o USD (Dólar Estadounidense)

**Código de País:** PA01

**Zona Horaria:** GMT-5 (Eastern Standard Time)
