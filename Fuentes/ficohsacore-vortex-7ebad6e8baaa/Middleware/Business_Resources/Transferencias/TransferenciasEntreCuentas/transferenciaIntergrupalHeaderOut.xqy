xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$transferenciaIntergrupalInsertResponse" element="ns1:TransferenciaIntergrupalInsertResponse" location="../../../v2/BusinessServices/T24/TransferenciaIntergrupal/xsd/TransferenciaIntergrupalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaIntergrupalHeaderOut/";

declare function xf:transferenciaIntergrupalHeaderOut($transferenciaIntergrupalInsertResponse as element(ns1:TransferenciaIntergrupalInsertResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $transferenciaIntergrupalInsertResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transferenciaIntergrupalInsertResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $transferenciaIntergrupalInsertResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $transferenciaIntergrupalInsertResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $transferenciaIntergrupalInsertResponse as element(ns1:TransferenciaIntergrupalInsertResponse) external;

xf:transferenciaIntergrupalHeaderOut($transferenciaIntergrupalInsertResponse)