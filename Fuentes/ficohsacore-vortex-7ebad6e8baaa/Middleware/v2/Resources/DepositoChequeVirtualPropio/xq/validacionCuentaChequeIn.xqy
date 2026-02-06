xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$depositoVirtualCheques" element="ns0:depositoVirtualCheques" location="../../DepositoVirtualCheques/xsd/depositoVirtualChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuenta" location="../../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoVirtualChequesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoChequeVirtualPropio/xq/validacionCuentaChequeIn/";

declare function xf:validacionCuentaChequeIn($depositoVirtualCheques as element(ns0:depositoVirtualCheques))
    as element(ns1:validacionCuenta) {
        <ns1:validacionCuenta>
            <ACCOUNT_NUMBER>{ data($depositoVirtualCheques/CHEQUE_ACCOUNT) }</ACCOUNT_NUMBER>
            <CHECK_CANCELLED_YES_NO>{ 'YES' }</CHECK_CANCELLED_YES_NO>
        </ns1:validacionCuenta>
};

declare variable $depositoVirtualCheques as element(ns0:depositoVirtualCheques) external;

xf:validacionCuentaChequeIn($depositoVirtualCheques)