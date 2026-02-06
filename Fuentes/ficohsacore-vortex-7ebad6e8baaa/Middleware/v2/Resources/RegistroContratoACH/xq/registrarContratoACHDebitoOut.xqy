xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registrodeContratoACHDebitoResponse" element="ns0:RegistrodeContratoACHDebitoResponse" location="../../../BusinessServices/T24/ACHContratos/xsd/XMLSchema_-1123798799.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registroContratoACHResponse" location="../xsd/registroContratoACHTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroContratoACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroContratoACH/xq/registrarContratoACHDebitoOut/";

declare function xf:registrarContratoACHDebitoOut($registrodeContratoACHDebitoResponse as element(ns0:RegistrodeContratoACHDebitoResponse))
    as element(ns1:registroContratoACHResponse) {
        <ns1:registroContratoACHResponse>
            <ID_CONTRATO>{ data($registrodeContratoACHDebitoResponse/Status/transactionId) }</ID_CONTRATO>
        </ns1:registroContratoACHResponse>
};

declare variable $registrodeContratoACHDebitoResponse as element(ns0:RegistrodeContratoACHDebitoResponse) external;

xf:registrarContratoACHDebitoOut($registrodeContratoACHDebitoResponse)