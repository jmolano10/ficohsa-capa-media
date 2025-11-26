(:: pragma bea:global-element-parameter parameter="$actualizaSistemas" element="ns1:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizarDatos" location="../../../BusinessServices/SALESFORCE/actualizaSistemaRG/wsdl/actualizaSalesforceRG.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_Actualizacion_Datos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizarDatosIn/";

declare function xf:actualizarDatosIn($actualizaSistemas as element(ns1:actualizaSistemas))
    as element(ns0:actualizarDatos) {
        <ns0:actualizarDatos>
            <ns0:parametros>
            {
             let $customerData := $actualizaSistemas/CUSTOMER_DATA
               return(
               
                    for $country in $customerData/SYSTEM_INFO/INFO[NAME = "COUNTRY"]
                    return
                     <ns0:CountryId>{ data($country/VALUE) }</ns0:CountryId>,
                    for $customerId in $customerData/CUSTOMER_INFO/INFO[NAME = "CUSTOMER_ID"]
                    return  
                 <ns0:CustomerId>{ data($customerId/VALUE) }</ns0:CustomerId>,
                <ns0:FieldsBeforeModify/>,
                <ns0:Observations/>,
                    let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('ddMMyyyy',string($customerData/CONTROL_INFO/INFO[NAME="CREATION_DATE"]/VALUE/text())))
                    let $time :=  fn-bea:time-to-string-with-format('HH:mm:ss',fn-bea:time-from-string-with-format("HH:mm:ss",string($customerData/CONTROL_INFO/INFO[NAME="UPDATE_TIME"]/VALUE/text())))
                    return
                              <ns0:OperationDate>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-ddHH:mm:ss",fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", string(concat($date,$time)))) }</ns0:OperationDate>,
                                <ns0:OperationType>{ data($actualizaSistemas/OPERATION_TYPE) }</ns0:OperationType>,
                              <ns0:Request>{ fn-bea:serialize($customerData) }</ns0:Request>,
                <ns0:Response/>,
                <ns0:StatusRequest>SUCCESS</ns0:StatusRequest>,
                <ns0:StatusResponse/>,
                 <ns0:TargetSystem>SALESFORCETC</ns0:TargetSystem>,
                    for $uuid in $customerData/CUSTOMER_INFO/INFO[NAME = "UUID"]
                    return  
                             <ns0:Uuid>{ data($uuid/VALUE) }</ns0:Uuid>
                
                )
             }
            </ns0:parametros>
        </ns0:actualizarDatos>
};

declare variable $actualizaSistemas as element(ns1:actualizaSistemas) external;

xf:actualizarDatosIn($actualizaSistemas)