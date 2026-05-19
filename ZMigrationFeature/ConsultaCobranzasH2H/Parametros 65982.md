##### 4.1.3.1. DynamoDB - Parámetros regionalización, negocio y conexión:
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#COLLECTION_RETRIEVE#PARAM#RETRIEVE",
  "sk": "V#0001",
  "name": "RETRIEVE",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "operation": "CONSULTA",
      "maxRequestAllowed": "6",
      "operationFields": "CON",
      "localCurrency": "HNL",
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
  "type": "list",
  "description": "CONFIG OF COLLECTION_RETRIEVE BY METHOD",
  "country": "XRS",
  "domain": "COLLECTION_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2026-07-17T10:00:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

##### 4.1.3.2. AWS Systems Manager Parameter Store

##### 4.1.3.3. AWS Systems Manager SecretManager



##### 4.1.3.4. Constantes para almacenar en ConfigMap

```json
{
  "caller-service": "COLLECTIONS_RETRIEVE-COMPOSITION-RETRIEVE"
}
```


##### 4.1.3.5. Registro Dynamo para homologación del caller-service
```json
{
  "pk": "COUNTRY#XRS#DOMAIN#CALLER_SERVICE#PARAM#CATALOGATE",
  "sk": "V#0001",
  "name": "CATALOGATE",
  "type": "JSON",
  "description": "CONFIG OF CALLER_SERVICE BY BACKEND",
  "country": "XRS",
  "domain": "CALLER_SERVICE",
  "value": [
    {
      "name": "COLLECTIONS_RETRIEVE-COMPOSITION-RETRIEVE",
      "description": "Caller service del servicio consulta cobranzas H2H", 
      "idProxy": "FICBCO0258"
    }
  ],
  "status": "active",
  "updated_at": "2025-09-23T18:10:00Z"
}
```

##### Transformaciones y Mapeos

**Mapeo del array additionalInformation[], en el consumo de la Fachada Inversa para consumo de collection-retrieve**

Para todos los casos es necesario tener en cuenta este **Ejemplo Response del API Collections Retrieve - Product** -  *HU 66016* - Endpoint: - GET /collections/collections-retrieve/v1/retrieve-collection-field

```json
{
   "meta":{
      "bian":{
         "businessArea":"OperationsAndExecution",
         "businessDomain":"CollateralAdministration",
         "serviceDomain":"Collections"
      }
   },
   "data":{
      "collectionFieldList":[
         {
            "originField":"RTN",
            "destinationPosition": 2
         },
         {
            "originField":"LIQ",
            "destinationPosition": 3
         }
      ]
   }
}
```

- **DIAGRAMA PASO 3A:**

Si el request de la API de composisión (HU65982) se recibe de esta manera:

```json
{
  "data": {
    "customerReference": "string",
    "services": {
      "serviceList": [
        {
          "serviceId": "string",
          "debtors": {
            "debtorList": [
              {
                "trace": "string",
                "debtorCode": "string",
                "currencyCode": "EUR",
                "returnType": "ALL",
                "extendedCollection": "YES",
                "additionalInfo": {
                  "infoList": [
                    {
                      "fieldName": "RTN",
                      "fieldValue": "123123123"
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

Entonces el request de la API Fachada se construye de la siguiente manera:  

```json
{
   "data":{
      "collectionAgreementReference":"string",
      "debtorReference":"string",
      "debtorName":"string",
      "paymentInstruction":{
         "paymentMethod":"CASH",
         "paymentCurrency":"string",
         "paymentAmount":"string",
         "accountNumber":"string",
         "chequeNumber":"string",
         "bankReference":"string",
         "creditCardId":"string",
         "cardExpirationDate":"2026-05-18"
      },
      "invoiceReference":{
         "invoiceNumber":"string",
         "invoiceDueDate":"2026-05-18"
      },
      "extendedCollectionIndicator":"YES",
      "dealslipPickupBranchReference":"string",
      "supplementaryData":[
         {
            "data":""
         },
         {
            "data":"123123123"
         },
         {
            "data":""
         }
      ],
      "paymentDescription":"string"
   }
}
```

En el ejemplo anterior se tienen en cuenta los campos:

- `"originField"` y `"destinationPosition"` del response del API Collections Retrieve - Product
- El valor máximo para `"destinationPosition"` es 3, lo que indica que el tamaño máximo del array `"supplementaryData[]"` va a ser 3, por lo tanto existen 3 subobjetos `"data"` dentro del array.
- El response del API Collections Retrieve - Product indica que `"originField": "RTN"` y `"destinationPosition": "2"` esto indica que valor del campo `"fieldValue": "123123123"` que pertenece al `"fieldName": "RTN"` se debe asígnar en el segundo objeto `"data"` del array `"supplementaryData[]"`

Veamos otro ejemplo: 

Si el request de la API de composisión (HU65982) se recibe de esta manera:

```json
{
  "data": {
    "customerReference": "string",
    "services": {
      "serviceList": [
        {
          "serviceId": "string",
          "debtors": {
            "debtorList": [
              {
                "trace": "string",
                "debtorCode": "string",
                "currencyCode": "EUR",
                "returnType": "ALL",
                "extendedCollection": "YES",
                "additionalInfo": {
                  "infoList": [
                    {
                      "fieldName": "RTN",
                      "fieldValue": "123123123"
                    },
                    {
                      "fieldName": "LIQ",
                      "fieldValue": "987987987"
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

Entonces el request de la API Fachada se construye de la siguiente manera:  

```json
{
   "data":{
      "collectionAgreementReference":"string",
      "debtorReference":"string",
      "debtorName":"string",
      "paymentInstruction":{
         "paymentMethod":"CASH",
         "paymentCurrency":"string",
         "paymentAmount":"string",
         "accountNumber":"string",
         "chequeNumber":"string",
         "bankReference":"string",
         "creditCardId":"string",
         "cardExpirationDate":"2026-05-18"
      },
      "invoiceReference":{
         "invoiceNumber":"string",
         "invoiceDueDate":"2026-05-18"
      },
      "extendedCollectionIndicator":"YES",
      "dealslipPickupBranchReference":"string",
      "supplementaryData":[
         {
            "data":""
         },
         {
            "data":"123123123"
         },
         {
            "data":"987987987"
         }
      ],
      "paymentDescription":"string"
   }
}
```

- **DIAGRAMA PASO 3B:**

Como El response del API Collections Retrieve - Product no indica `"destinationPosition": "1"` entonces el primer objeto `"data"` del array `"supplementaryData[]"` se debe asignar vacío, como se muestra en los ejemplos anteriores. 

- **DIAGRAMA PASO 3C:**

Si el request de la API de composisión (HU65982) se recibe de esta manera:

```json
{
  "data": {
    "customerReference": "string",
    "services": {
      "serviceList": [
        {
          "serviceId": "string",
          "debtors": {
            "debtorList": [
              {
                "trace": "string",
                "debtorCode": "string",
                "currencyCode": "EUR",
                "returnType": "ALL",
                "extendedCollection": "YES",
                "additionalInfo": {
                  "infoList": [
                    {
                      "fieldName": "RTN",
                      "fieldValue": ""
                    },
                    {
                      "fieldName": "LIQ",
                      "fieldValue": "987987987"
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

Entonces el request de la API Fachada se construye de la siguiente manera:  

```json
{
   "data":{
      "collectionAgreementReference":"string",
      "debtorReference":"string",
      "debtorName":"string",
      "paymentInstruction":{
         "paymentMethod":"CASH",
         "paymentCurrency":"string",
         "paymentAmount":"string",
         "accountNumber":"string",
         "chequeNumber":"string",
         "bankReference":"string",
         "creditCardId":"string",
         "cardExpirationDate":"2026-05-18"
      },
      "invoiceReference":{
         "invoiceNumber":"string",
         "invoiceDueDate":"2026-05-18"
      },
      "extendedCollectionIndicator":"YES",
      "dealslipPickupBranchReference":"string",
      "supplementaryData":[
         {
            "data":""
         },
         {
            "data":"ERROR"
         },
         {
            "data":"987987987"
         }
      ],
      "paymentDescription":"string"
   }
}
```

Como no existe valor en el campo `"fieldValue"`para `"fieldName": "RTN"` entonces se asigna `"ERROR"` en el segundo objeto `"data"` del array `"supplementaryData[]"` porque el response del API Collections Retrieve - Product indica que `"originField": "RTN"` y `"destinationPosition": "2"`.