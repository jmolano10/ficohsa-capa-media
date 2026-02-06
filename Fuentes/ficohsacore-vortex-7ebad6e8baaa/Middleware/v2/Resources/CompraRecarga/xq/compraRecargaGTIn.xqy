xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$compraRecarga" element="ns0:compraRecarga" location="../../../../Business_Resources/recargas/CompraRecarga/compraRecargaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../v3/BusinessServices/ABKGT/PagoRecaudo/xsd/PagoRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/compraRecargaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraRecarga/xq/CompraRecargaGTIn/";

declare function xf:CompraRecargaGTIn($compraRecarga as element(ns0:compraRecarga))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CONTRACT_ID>{ data($compraRecarga/SERVICE_PROVIDER_ID) }</ns1:PV_CONTRACT_ID>
            <ns1:PV_DEBTOR_CODE>{ data($compraRecarga/PHONE_NUMBER) }</ns1:PV_DEBTOR_CODE>
            <ns1:PV_PAYMENT_AMOUNT>{ data($compraRecarga/AMOUNT) }</ns1:PV_PAYMENT_AMOUNT>
            <ns1:PV_DEBIT_ACCOUNT>{ data($compraRecarga/DEBIT_ACCOUNT) }</ns1:PV_DEBIT_ACCOUNT>
            <ns1:PV_DATA></ns1:PV_DATA>
        </ns1:InputParameters>
};

declare variable $compraRecarga as element(ns0:compraRecarga) external;

xf:CompraRecargaGTIn($compraRecarga)