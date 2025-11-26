(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentaporCancelar_ValidateResponse" element="ns0:ConsultaSaldoCuentaporCancelar_ValidateResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuentaPorCancelar/consultaSaldoCuentaPorCancelarHeaderOut/";

declare function xf:consultaSaldoCuentaPorCancelarHeaderOut($consultaSaldoCuentaporCancelar_ValidateResponse as element(ns0:ConsultaSaldoCuentaporCancelar_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultaSaldoCuentaporCancelar_ValidateResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultaSaldoCuentaporCancelar_ValidateResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultaSaldoCuentaporCancelar_ValidateResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultaSaldoCuentaporCancelar_ValidateResponse as element(ns0:ConsultaSaldoCuentaporCancelar_ValidateResponse) external;

xf:consultaSaldoCuentaPorCancelarHeaderOut($consultaSaldoCuentaporCancelar_ValidateResponse)