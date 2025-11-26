(:: pragma bea:global-element-parameter parameter="$reversionfaltosobrcajeroResponse" element="ns0:ReversionfaltosobrcajeroResponse" location="../../xsds/ReversaTransaccion2/XMLSchema_-704599497.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionFaltanteSobranteCajero/ReversionFaltanteSobranteCajeroHeaderOut/";

declare function xf:ReversionFaltanteSobranteCajeroHeaderOut($reversionfaltosobrcajeroResponse as element(ns0:ReversionfaltosobrcajeroResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversionfaltosobrcajeroResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $reversionfaltosobrcajeroResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $reversionfaltosobrcajeroResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE1 in $reversionfaltosobrcajeroResponse/TELLERType/VALUEDATE1
                return
                    <valueDate>{ data($VALUEDATE1) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $reversionfaltosobrcajeroResponse as element(ns0:ReversionfaltosobrcajeroResponse) external;

xf:ReversionFaltanteSobranteCajeroHeaderOut($reversionfaltosobrcajeroResponse)