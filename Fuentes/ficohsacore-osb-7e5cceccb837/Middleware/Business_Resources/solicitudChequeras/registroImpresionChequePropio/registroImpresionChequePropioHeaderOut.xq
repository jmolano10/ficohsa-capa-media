(:: pragma bea:global-element-parameter parameter="$registrodechequerapropimpresionResponse" element="ns0:RegistrodechequerapropimpresionResponse" location="../Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/registroImpresionChequePropio/registroImpresionChequePropioHeaderOut/";

declare function xf:registroImpresionChequePropioHeaderOut($registrodechequerapropimpresionResponse as element(ns0:RegistrodechequerapropimpresionResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $registrodechequerapropimpresionResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $registrodechequerapropimpresionResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $registrodechequerapropimpresionResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $REQUESTDATE in $registrodechequerapropimpresionResponse/FICOHCHECKBOOKREQUESTType/REQUESTDATE
                return
                    <valueDate>{ data($REQUESTDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $registrodechequerapropimpresionResponse as element(ns0:RegistrodechequerapropimpresionResponse) external;

xf:registroImpresionChequePropioHeaderOut($registrodechequerapropimpresionResponse)