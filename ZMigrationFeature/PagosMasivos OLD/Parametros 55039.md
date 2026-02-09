##### DynamoDB Parameter - Parámetros método  Parámetros /v1/retrieve-status 
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#MANTAIN_PARTY_DIGITAL_REFRENCE#PARAM#v1-retrieve-status",
  "sk": "V#0001",
  "name": "v1-retrieve-status",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name-val-access": "ban-xrs-xx-valida-acceso-pms-param-wsdl",
      "param-name-wrapper-proxy-abanks-hn": "ban-xrs-ic-consumo-wrapper-abanks-hn-wsdl"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name-cons-est-lote": "ban-xrs-xx-consulta-estado-lote-v1-param-wsdl-<env>"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name-cons-est-lote": "ban-xrs-xx-consulta-estado-lote-v1-param-wsdl-<env>"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name-cons-est-lote": "ban-xrs-xx-consulta-estado-lote-v1-param-wsdl-<env>"
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
"ban-hn-ic-consumo-wrapper-abanks-hn-wsdl"
{
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "proxyabankshn"
}
```
```json
"ban-xrs-ap-consulta-estado-lote-v1-param-wsdl-<dev>"
{
  "ip": "https://172.23.14.243",
  "port": "7004",
  "basePath": "ConsultaLotePmsWS/services/consultorLoteEndpoint"
}
```
```json
"ban-xrs-ap-consulta-estado-lote-v1-param-wsdl-<qa>"
{
  "ip": "https://172.23.179.99",
  "port": "7008",
  "basePath": "ConsultaLotePmsWS/services/consultorLoteEndpoint"
}
```
##### Constantes para almacenar en ConfigMap

```json
{
  "procedureNameConsultaLote": "PMS_P_CON_ESTADO_LOTE",
  "procedureNameValidaAcceso": "OSB_P_VALIDA_ACCESO_PMS"
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
      "name": "S",
      "value": "YES",
      "description": "SI"
    },
    {
      "name": "N",  
      "value": "NO",    
      "description": "NO"
    }
  ],
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z"
}
```