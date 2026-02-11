##### DynamoDB Parameter - Parámetros método  Parámetros /v1/retrieve-status 
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#MANTAIN_PARTY_DIGITAL_REFRENCE#PARAM#v1-retrieve-status",
  "sk": "V#0001",
  "name": "v2-retrieve-status",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "secret-name": "ban-hnd-ap-secm-corporate-payment-{application-id}-<env>",
      "param-name-api-pagos-masivos": "ban-hnd-ap-parm-corporate-payment-pm-url-{env}",
      "queryType": "BANK_BATCH_ID",
      "queryvalue": "bankBatchId"

    },
    {
      "region": "GT01-GT01",
      "enabled": false
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
  "description": "CONFIG OF MANTAIN_PARTY_DIGITAL_REFRENCE BY METHOD",
  "country": "XRS",
  "domain": "MANTAIN_PARTY_DIGITAL_REFRENCE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "eudis.perdomo@ficohsa.com"
}
```
##### AWS Systems Manager Parameter Store

```json
"ban-hnd-ap-secm-corporate-payment-pm-url-{env}"
{
  "ip": "https://masivos-api-dev.gfficohsa.hn",
  "port": "",
  "basePath": "/api/PagosMasivos",
  "method": "POST"
}
```

##### Constantes para almacenar en ConfigMap

```json
{
  "operation": "ConsultaEstadoLote"
}
```

##### Parámetros Homologación
```json
{
  "pk": "COUNTRY#XRS#DOMAIN#YES_NO#PARAM#CATALOGATE",
  "sk": "V#0001",
  "name": "CATALOGATE",
  "type": "JSON",
  "description": "CONFIG OF YES_NO BY BACKEND",
  "country": "XRS",
  "domain": "YES_NO",
  "value": [
    {
      "name": "YES",
      "valueOld": "1", 
      "valueNew": true,  
      "description": "SI"
    },
    {
      "name": "NO",  
      "valueOld": "0",  
      "valueNew": false,  
      "description": "NO"
    }
  ],
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z"
}
```