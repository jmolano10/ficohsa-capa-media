(:: pragma bea:global-element-parameter parameter="$actualizaSistemas" element="ns0:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/VisionPlus/ActualizacionesCliente/xsd/actualizacionesCliente_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizacionesCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionesClienteIn/";

declare function xf:actualizacionesClienteIn($actualizaSistemas as element(ns0:actualizaSistemas),$pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $pais }</ns1:Pais>
            <ns1:UUID>{ data($actualizaSistemas/CUSTOMER_DATA/CUSTOMER_INFO/INFO[NAME = "UUID"]/VALUE) }</ns1:UUID>
            <ns1:CustomerID>{ data($actualizaSistemas/CUSTOMER_DATA/CUSTOMER_INFO/INFO[NAME = "CUSTOMER_ID"]/VALUE) }</ns1:CustomerID>
            <ns1:TargetSystem>{ data($actualizaSistemas/CUSTOMER_DATA/SYSTEM_INFO/INFO[NAME = "TARGET_SYSTEM"]/VALUE) }</ns1:TargetSystem>
            <ns1:CountryId>{ data($actualizaSistemas/CUSTOMER_DATA/SYSTEM_INFO/INFO[NAME = "COUNTRY"]/VALUE) }</ns1:CountryId>
            {
                    let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('ddMMyyyy',string($actualizaSistemas/CUSTOMER_DATA/CONTROL_INFO/INFO[NAME="CREATION_DATE"]/VALUE/text())))
                    let $time :=  fn-bea:time-to-string-with-format('HH:mm:ss',fn-bea:time-from-string-with-format("HH:mm:ss",string($actualizaSistemas/CUSTOMER_DATA/CONTROL_INFO/INFO[NAME="UPDATE_TIME"]/VALUE/text())))
                    return
                    <ns1:OperationDate>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-ddHH:mm:ss",fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", string(concat($date,$time)))) }</ns1:OperationDate>
            }
            <ns1:OperationType>{ data($actualizaSistemas/OPERATION_TYPE) }</ns1:OperationType>
            <ns1:Request>{ fn-bea:serialize($actualizaSistemas/CUSTOMER_DATA) }</ns1:Request>
        </ns1:InputParameters>
};

declare variable $actualizaSistemas as element(ns0:actualizaSistemas) external;
declare variable $pais as xs:string external;
xf:actualizacionesClienteIn($actualizaSistemas,$pais)