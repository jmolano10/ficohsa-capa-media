xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentasResponse" element="ns0:TransferenciaentrecuentasResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasHeaderOut/";

declare function xf:transferenciaCuentasHeaderOut($transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transferenciaentrecuentasResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transferenciaentrecuentasResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $transferenciaentrecuentasResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse) external;

xf:transferenciaCuentasHeaderOut($transferenciaentrecuentasResponse)