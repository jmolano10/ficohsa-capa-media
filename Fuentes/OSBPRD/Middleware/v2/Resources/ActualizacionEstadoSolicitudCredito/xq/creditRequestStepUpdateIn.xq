(:: pragma bea:global-element-parameter parameter="$actualizacionEstadoSolicitudCredito" element="ns1:actualizacionEstadoSolicitudCredito" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creditRequestStepUpdate" location="../../../BusinessServices/SALESFORCE/recepEvalCreditos/wsdl/WS_NIC_Recepcion_Eval_Creditos.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_NIC_Recepcion_Eval_Creditos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizacionEstadoSolicitudCredito/xq/creditRequestStepUpdateIn/";

declare function xf:creditRequestStepUpdateIn($actualizacionEstadoSolicitudCredito as element(ns1:actualizacionEstadoSolicitudCredito))
    as element(ns0:creditRequestStepUpdate) {
        <ns0:creditRequestStepUpdate>
            <ns0:idProspecto>{ data($actualizacionEstadoSolicitudCredito/REQUESTED_ID) }</ns0:idProspecto>
            <ns0:idCreditRequest>{ data($actualizacionEstadoSolicitudCredito/CREDIT_REQUEST_ID) }</ns0:idCreditRequest>
            <ns0:RequestStatus>{ data($actualizacionEstadoSolicitudCredito/REQUEST_STATUS) }</ns0:RequestStatus>
        </ns0:creditRequestStepUpdate>
};

declare variable $actualizacionEstadoSolicitudCredito as element(ns1:actualizacionEstadoSolicitudCredito) external;

xf:creditRequestStepUpdateIn($actualizacionEstadoSolicitudCredito)