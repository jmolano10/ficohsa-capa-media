(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../BusinessServices/ProcesosGT/eCConRequestControl/xsd/eCConRequestControl_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCConRequestControl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosGT/xq/eCConRequestControlIGTIn/";

declare function xf:eCConRequestControlIGTIn($batch_id as xs:string,
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_lote>{ $batch_id }</ns1:i_lote>
            <ns1:i_pais>{ $codigoPais }</ns1:i_pais>
        </ns1:InputParameters>
};

declare variable $batch_id as xs:string external;
declare variable $codigoPais as xs:string external;

xf:eCConRequestControlIGTIn($batch_id,
    $codigoPais)