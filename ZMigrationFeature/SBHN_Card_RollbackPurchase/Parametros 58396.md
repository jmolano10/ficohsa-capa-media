##### DynamoDB Parameter - Lambda Parámetros
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#HND#DOMAIN#CREDIT_CARD_STATUS_RETRIEVE#PARAM#RETRIEVE_PURCHASE_TICKET",
  "sk": "V#0001",
  "name": "RETRIEVE_PURCHASE_TICKET",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name": "ban-xrs-ic-comp-parm-pagos-db-dev",
      "secret-name": "ban-xrs-ic-comp-secm-pagos-db-dev"
    },
    {
      "region": "GT01-GT01",
      "enabled": true
    },
    {
      "region": "NI01-NI01",
      "enabled": false
    },
    {
      "region": "PA01-PA01",
      "enabled": false
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF CREDIT_CARD_STATUS_RETRIEVE BY METHOD",
  "country": "HND",
  "domain": "CREDIT_CARD_STATUS_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-xrs-ic-comp-parm-pagos-db-dev"
{
  "ip": "172.23.176.22",
  "port": "1970",
  "bdName": "pagoswsd"
}
```

##### AWS Systems Manager SecretManager

```json
"ban-xrs-ic-comp-secm-pagos-db-dev"
{
  "username": "PAGOSWSTC",
  "password": "desarrollo"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operationType": "query",
  "schemaHN": "PAGOSWSTC",
  "packageHN": "OSB_K_RECAUDO_BROKER_HN",
  "procedureNameHN": "OSB_CONS_BROKER_RECAUDO_TICKET",
  "schemaGT": "PAGOSWSTC",
  "packageGT": "OSB_K_RECAUDO_BROKER_GT",
  "procedureNameGT": "OSB_CONS_BROKER_RECAUDO_TICKET",
}
```

##### Ejemplo Request Wrapper Connection Pagos WSTC
```json
{
  "connection": {
    "parm": "ban-xrs-ic-comp-parm-pagos-db-dev",
    "secm": "ban-xrs-ic-comp-secm-pagos-db-dev"
  },
  "schema": "PAGOSWSTC",
  "package": "OSB_K_RECAUDO_BROKER_HN",
  "procedureName": "OSB_CONS_BROKER_RECAUDO_TICKET",
  "operationType": "query",
  "parameters": {
    "PV_TICKET": "TKT123456",

  }
}
```

##### Ejemplo de response Wrapper Connection Pagos WSTC
```json
{
  "success": true,
  "data": {
    "outputParameters": {
      "PV_ESTADO_TICKET": "PROCESADO",
      "PN_AGENCIAORIGEN": 101,
      "PV_MERCHANTNUMBER": "MER0012345",
      "PV_NUMEROTARJETA": "4111111111111111",
      "PV_TIPOOPERACION": "COMPRA",
      "PN_TIPOMONEDA": 840,
      "PN_ORGANIZACION": 1,
      "PV_MONEDATRANSACCION": "USD",
      "PN_TASACAMBIO": 1.0,
      "PN_TIPOTRANSACCION": 5,
      "PV_CODIGOUSUARIO": "USR00123",
      "PV_SECUENCIAMOVIMIENTO": "SEQ20260313001",
      "PV_SECUENCIAORIGEN": "ORIG20260313001",
      "PN_VALOREFECTIVO": 150.75,
      "PN_VALORCHEQUES": 0,
      "PN_NUMERODOCUMENTO": 987654321,
      "PD_FECHAVALIDA": "2026-03-13",
      "PN_TIPOCHEQUE": 0,
      "PV_BANCOORIGEN": "FICOHSA",
      "PV_BANCODESTINO": "FICOHSA",
      "PV_DESCRIPCIONTRANSACCION": "COMPRA EN COMERCIO",
      "PV_CANAL": "APP_MOVIL",
      "PV_NUMEROAUTORIZACION": "AUTH789456",
      "PV_APLICADO": "S",
      "PV_APLICARENLINEA": "S",
      "PV_FECHAEXPTC": "2028-12",
      "PV_SUCCESSINDICATOR": "SUCCESS",
      "PV_MESSAGES": ""
    }
  },
  "metadata": {
    "executionTime": 234
  }
}
```
##### Ejemplo mensaje en Event Brigde para componente de Idempotencia

##### Ejemplo request consumo operacion OnlineUpdateCard Vision Plus
```xml

```

