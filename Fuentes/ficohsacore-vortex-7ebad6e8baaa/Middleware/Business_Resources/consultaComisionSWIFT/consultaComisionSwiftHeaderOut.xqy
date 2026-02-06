xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacional_ValidateResponse" element="ns0:TransferenciaInternacional_ValidateResponse" location="../Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaComisionSWIFT/consultaComisionSwiftHeaderOut/";

declare function xf:consultaComisionSwiftHeaderOut($transferenciaInternacional_ValidateResponse as element(ns0:TransferenciaInternacional_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transferenciaInternacional_ValidateResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transferenciaInternacional_ValidateResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $transferenciaInternacional_ValidateResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $transferenciaInternacional_ValidateResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $transferenciaInternacional_ValidateResponse as element(ns0:TransferenciaInternacional_ValidateResponse) external;

xf:consultaComisionSwiftHeaderOut($transferenciaInternacional_ValidateResponse)