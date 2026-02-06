xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$Response" element="ns1:TransfmodelbankentrecuentasResponse" location="Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/ProgramadasACHHeaderOut/";

declare function xf:ProgramadasACHHeaderOut($Response as element(ns1:TransfmodelbankentrecuentasResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $Response/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $Response/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $Response/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $Response/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $Response as element(ns1:TransfmodelbankentrecuentasResponse) external;

xf:ProgramadasACHHeaderOut($Response)