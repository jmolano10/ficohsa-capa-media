(:: pragma bea:global-element-parameter parameter="$actualizaEstadoRemesaRequest" element="ns1:actualizaEstadoRemesaRequest" location="../xsd/actualizaEstadoRemesa.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Remesas/cancelacionRemesaLocal/xsd/cancelacionRemesaLocal_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cancelacionRemesaLocal";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoRemesaTypes/v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerCancelacionRemesaLocalIn/";

declare function xf:aerCancelacionRemesaLocalIn($actualizaEstadoRemesaRequest as element(ns1:actualizaEstadoRemesaRequest),
    $userName as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_USUARIO>{ $userName }</ns0:PV_USUARIO>
            <ns0:PV_REMESAID>{ data($actualizaEstadoRemesaRequest/REMITTANCE_ID) }</ns0:PV_REMESAID>
        </ns0:InputParameters>
};

declare variable $actualizaEstadoRemesaRequest as element(ns1:actualizaEstadoRemesaRequest) external;
declare variable $userName as xs:string external;

xf:aerCancelacionRemesaLocalIn($actualizaEstadoRemesaRequest,
    $userName)