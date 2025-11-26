(:: pragma bea:global-element-parameter parameter="$actualizaEstadoRemesaRequest" element="ns0:actualizaEstadoRemesaRequest" location="../xsd/actualizaEstadoRemesa.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaEstadoRemesaResponse" location="../xsd/actualizaEstadoRemesa.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoRemesaTypes/v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerActualizaEstadoRemCancelledOut/";

declare function xf:aerActualizaEstadoRemCancelledOut($actualizaEstadoRemesaRequest as element(ns0:actualizaEstadoRemesaRequest),
    $previousStatus as xs:string)
    as element(ns0:actualizaEstadoRemesaResponse) {
        <ns0:actualizaEstadoRemesaResponse>
            <REMITTANCE_ID>{ data($actualizaEstadoRemesaRequest/REMITTANCE_ID) }</REMITTANCE_ID>
            <REMITTER_ID>{ data($actualizaEstadoRemesaRequest/REMITTER_ID) }</REMITTER_ID>
            <PREVIOUS_STATUS>{ $previousStatus }</PREVIOUS_STATUS>
            <NEW_STATUS>{ data($actualizaEstadoRemesaRequest/NEW_STATUS) }</NEW_STATUS>
        </ns0:actualizaEstadoRemesaResponse>
};

declare variable $actualizaEstadoRemesaRequest as element(ns0:actualizaEstadoRemesaRequest) external;
declare variable $previousStatus as xs:string external;

xf:aerActualizaEstadoRemCancelledOut($actualizaEstadoRemesaRequest,
    $previousStatus)
