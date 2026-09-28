(:: pragma bea:global-element-parameter parameter="$transfmodelbankentrecuentasResponse" element="ns0:TransfmodelbankentrecuentasResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasPensionadosHeaderOut/";

declare function xf:transferenciaCuentasPensionadosHeaderOut($transfmodelbankentrecuentasResponse as element(ns0:TransfmodelbankentrecuentasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transfmodelbankentrecuentasResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transfmodelbankentrecuentasResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $transfmodelbankentrecuentasResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $transfmodelbankentrecuentasResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $transfmodelbankentrecuentasResponse as element(ns0:TransfmodelbankentrecuentasResponse) external;

xf:transferenciaCuentasPensionadosHeaderOut($transfmodelbankentrecuentasResponse)