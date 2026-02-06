xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns1:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Parametros" location="../../../BusinessServices/SALESFORCE/ActualizarSistema/wsdl/ActualizaDatosClienteSalesforce.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/AD_Actualizar_Sistemas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizaSistemasSalesforceIn/";

declare function xf:actualizaSistemasSalesforceIn($actualizaSistemas1 as element(ns1:actualizaSistemas))
    as element(ns0:Parametros) {
        <ns0:Parametros>
        {
        let $actualizaSistemas := $actualizaSistemas1/CUSTOMER_DATA
        return(
                    for $uuid in $actualizaSistemas/CUSTOMER_INFO/INFO[NAME = "UUID"]
                    return  
                             <ns0:Uuid>{ data($uuid/VALUE) }</ns0:Uuid>,
                    for $customerId in $actualizaSistemas/CUSTOMER_INFO/INFO[NAME = "CUSTOMER_ID"]
                    return  
                             <ns0:CustomerId>{ data($customerId/VALUE) }</ns0:CustomerId>,
                             <ns0:TargetSystem>SALESFORCETC</ns0:TargetSystem>,
                    for $country in $actualizaSistemas/SYSTEM_INFO/INFO[NAME = "COUNTRY"]
                    return
                              <ns0:CountryId>{ data($country/VALUE) }</ns0:CountryId>,
                    let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('ddMMyyyy',string($actualizaSistemas/CONTROL_INFO/INFO[NAME="CREATION_DATE"]/VALUE/text())))
                    let $time :=  fn-bea:time-to-string-with-format('HH:mm:ss',fn-bea:time-from-string-with-format("HH:mm:ss",string($actualizaSistemas/CONTROL_INFO/INFO[NAME="UPDATE_TIME"]/VALUE/text())))
                    return
                              <ns0:OperationDate>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-ddHH:mm:ss",fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", string(concat($date,$time)))) }</ns0:OperationDate>,
                              <ns0:OperationType>{ data($actualizaSistemas1/OPERATION_TYPE) }</ns0:OperationType>,
                    for $customerData in $actualizaSistemas
                    return
                              <ns0:Request>{ fn-bea:serialize($customerData) }</ns0:Request>,
                              <ns0:StatusRequest>SUCCESS</ns0:StatusRequest>,
                              <ns0:Response/>,
                              <ns0:StatusResponse/>,
                              <ns0:FieldsBeforeModify/>,
                              <ns0:Observations/>
            )
            }
        </ns0:Parametros>
};

declare variable $actualizaSistemas1 as element(ns1:actualizaSistemas) external;

xf:actualizaSistemasSalesforceIn($actualizaSistemas1)