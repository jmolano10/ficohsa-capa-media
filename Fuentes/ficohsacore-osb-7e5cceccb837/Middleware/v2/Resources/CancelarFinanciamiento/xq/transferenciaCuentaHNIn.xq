(:: pragma bea:global-element-parameter parameter="$cancelarFinanciamiento" element="ns0:cancelarFinanciamiento" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasRequest" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/transferenciaCuentaHNIn/";

declare function xf:transferenciaCuentaHNIn($cancelarFinanciamiento as element(ns0:cancelarFinanciamiento),
    $currency as xs:string,
    $creditAccount as xs:string,
    $description as xs:string,
    $uuid as xs:string)
    as element(ns1:transferenciaCuentasRequest) {
        <ns1:transferenciaCuentasRequest>
            <DEBIT_ACCOUNT>{ data($cancelarFinanciamiento/CANCELLATION_DETAILS/DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            <CREDIT_ACCOUNT>{ $creditAccount }</CREDIT_ACCOUNT>
            <CURRENCY>{ $currency }</CURRENCY>
            <TRANSFER_AMOUNT>{ data($cancelarFinanciamiento/CANCELLATION_DETAILS/AMOUNT) }</TRANSFER_AMOUNT>
            <DESCRIPTION>{ concat($cancelarFinanciamiento/CREDIT_CARD_INFO/CARD_NUMBER, ' ', $description, ': ', $cancelarFinanciamiento/FINANCING_DETAILS/ID) }</DESCRIPTION>
            <INTERFACE_REFERENCE_NO>{ $uuid }</INTERFACE_REFERENCE_NO>
        </ns1:transferenciaCuentasRequest>
};

declare variable $cancelarFinanciamiento as element(ns0:cancelarFinanciamiento) external;
declare variable $currency as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $description as xs:string external;
declare variable $uuid as xs:string external;

xf:transferenciaCuentaHNIn($cancelarFinanciamiento,
    $currency,
    $creditAccount,
    $description,
    $uuid)
