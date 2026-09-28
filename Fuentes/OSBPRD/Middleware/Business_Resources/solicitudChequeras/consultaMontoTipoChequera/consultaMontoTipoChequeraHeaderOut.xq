(:: pragma bea:global-element-parameter parameter="$solicituddechequera_ValidateResponse" element="ns0:Solicituddechequera_ValidateResponse" location="../Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/consultaMontoTipoChequera/consultaMontoTipoChequeraHeaderOut/";

declare function xf:consultaMontoTipoChequeraHeaderOut($solicituddechequera_ValidateResponse as element(ns0:Solicituddechequera_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $solicituddechequera_ValidateResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $solicituddechequera_ValidateResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $solicituddechequera_ValidateResponse as element(ns0:Solicituddechequera_ValidateResponse) external;

xf:consultaMontoTipoChequeraHeaderOut($solicituddechequera_ValidateResponse)