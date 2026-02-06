xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transfentrecuentasinstrcreditoResponse" element="ns0:TransfentrecuentasinstrcreditoResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasCreditHeaderOut/";

declare function xf:transferenciaCuentasCreditHeaderOut($transfentrecuentasinstrcreditoResponse as element(ns0:TransfentrecuentasinstrcreditoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transfentrecuentasinstrcreditoResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transfentrecuentasinstrcreditoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $transfentrecuentasinstrcreditoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $transfentrecuentasinstrcreditoResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $transfentrecuentasinstrcreditoResponse as element(ns0:TransfentrecuentasinstrcreditoResponse) external;

xf:transferenciaCuentasCreditHeaderOut($transfentrecuentasinstrcreditoResponse)