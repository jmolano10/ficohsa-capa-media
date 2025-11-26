(:: pragma bea:global-element-parameter parameter="$emisiondechequedegerenciaFTResponse" element="ns0:EmisiondechequedegerenciaFTResponse" location="Resources/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaLocalHeaderOut/";

declare function xf:emisionChequesGerenciaLocalHeaderOut($emisiondechequedegerenciaFTResponse as element(ns0:EmisiondechequedegerenciaFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $emisiondechequedegerenciaFTResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $emisiondechequedegerenciaFTResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $emisiondechequedegerenciaFTResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $CREDITVALUEDATE in $emisiondechequedegerenciaFTResponse/FUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $emisiondechequedegerenciaFTResponse as element(ns0:EmisiondechequedegerenciaFTResponse) external;

xf:emisionChequesGerenciaLocalHeaderOut($emisiondechequedegerenciaFTResponse)