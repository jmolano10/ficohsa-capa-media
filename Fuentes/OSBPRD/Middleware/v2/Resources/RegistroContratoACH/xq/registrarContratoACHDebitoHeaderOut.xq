(:: pragma bea:global-element-parameter parameter="$registrodeContratoACHDebitoResponse" element="ns1:RegistrodeContratoACHDebitoResponse" location="../../../BusinessServices/T24/ACHContratos/xsd/XMLSchema_-1123798799.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistroContratoACH/xq/registrarContratoACHDebitoHeaderOut/";

declare function xf:registrarContratoACHDebitoHeaderOut($registrodeContratoACHDebitoResponse as element(ns1:RegistrodeContratoACHDebitoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $messageId in $registrodeContratoACHDebitoResponse/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            {
                for $successIndicator in $registrodeContratoACHDebitoResponse/Status/successIndicator
                return
                    <successIndicator>{ fn:upper-case(data($successIndicator)) }</successIndicator>
            }
            {
                for $messages in $registrodeContratoACHDebitoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $registrodeContratoACHDebitoResponse as element(ns1:RegistrodeContratoACHDebitoResponse) external;

xf:registrarContratoACHDebitoHeaderOut($registrodeContratoACHDebitoResponse)