(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns1:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/registraActualizaSistema/xsd/registraActualizaSistema_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraActualizaSistema";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteFicopenIn/";

declare function xf:actualizacionClienteFicopenIn($actualizaSistemas1 as element(ns1:actualizaSistemas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
            let $actualizaSistemas := $actualizaSistemas1/CUSTOMER_DATA
            return(
              for $customerId in $actualizaSistemas/CUSTOMER_INFO/INFO[NAME = "CUSTOMER_ID"]
                    return
            <ns0:VE_COD_CLIENTE>{ data($customerId/VALUE) }</ns0:VE_COD_CLIENTE>,
            
            for $uuid in $actualizaSistemas/CUSTOMER_INFO/INFO[NAME = "UUID"]
                    return  
            <ns0:VE_UUID>{ data($uuid/VALUE) }</ns0:VE_UUID>,
            let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('ddMMyyyy',string($actualizaSistemas/CONTROL_INFO/INFO[NAME="CREATION_DATE"]/VALUE/text())))
            let $time :=  fn-bea:time-to-string-with-format('HH:mm:ss',fn-bea:time-from-string-with-format("HH:mm:ss",string($actualizaSistemas/CONTROL_INFO/INFO[NAME="UPDATE_TIME"]/VALUE/text())))
                    return
             <ns0:VE_OPERATION_DATE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-ddHH:mm:ss",fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", string(concat($date,$time)))) }</ns0:VE_OPERATION_DATE>,
             <ns0:VE_OPERATION_TYPE>{ data($actualizaSistemas1/OPERATION_TYPE) }</ns0:VE_OPERATION_TYPE>,
             for $customerData in $actualizaSistemas
                    return
             <ns0:VE_REQUEST>{ fn-bea:serialize($customerData) }</ns0:VE_REQUEST>       
            )
        }
        </ns0:InputParameters>
};

declare variable $actualizaSistemas1 as element(ns1:actualizaSistemas) external;

xf:actualizacionClienteFicopenIn($actualizaSistemas1)
