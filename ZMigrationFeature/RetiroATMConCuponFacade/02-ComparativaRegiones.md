# 02 - Comparativa de Regiones: RetiroATMConCuponFacade

## Regiones Implementadas

| Aspecto | HN01 (Honduras) | Default (Otras) |
|---------|-----------------|-----------------|
| **Estado** | ✅ Implementado | ❌ No implementado |
| **Comportamiento** | Ejecuta flujo completo de retiro con cupón TENGO | Retorna error MW-0008: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" |
| **Validación Regional** | SP ValidaServicioRegional con serviceId="FICBCO0259" | N/A |
| **Sistemas invocados** | TENGO + T24 + BD Oracle | Ninguno |
| **Cuenta Billetera** | Parametrizada: FICBCO0259.151000.DEBITACCT (normal) / FICBCO0259.151000.DEBITACCT_TC (tarjeta crédito) | N/A |
| **Código Transacción** | Parametrizado: FICBCO0259.TRX.CODE | N/A |

## Branching en Facade (por MTI)

| MTI | Rama | Proxy destino | Operación |
|-----|------|---------------|-----------|
| 0200 | Retiro | RetiroATMConCupon | retiroATMConCupon |
| 0420, 0220 | Reversión | ReversaCuponATM | reversaCuponATM |
| Otro | Default | PipelinePairNode1 | Error MW-0008 |

## Notas
- Solo Honduras (HN01) tiene implementación activa.
- La regionalización se valida en el proxy hijo `RetiroATMConCupon`, no en el Facade.
- El Facade solo discrimina por MTI (tipo de mensaje ISO8583).
