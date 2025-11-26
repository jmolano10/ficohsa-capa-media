(:: pragma bea:global-element-parameter parameter="$creditCardQuery" element="ns0:creditCardQuery" location="../../../../../v1/Resources/CreditCardOperations/xsd/CreditCardOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../../v1/BusinessServices/AbanksGT/CONSSaldoTC/xsd/MCCONSSaldoTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creditCardOperationsTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSGT/MGC_K_GESTION_TC/MC_CONS_SALDO_TC/";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardQuery/xq/mcCONSSaldoTCGTIn/";

declare function xf:mcCONSSaldoTCGTIn($creditCardQuery as element(ns0:creditCardQuery))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CREDIT_CARD_NUMBER>{ xs:decimal(data($creditCardQuery/ns0:CREDIT_CARD_NUMBER)) }</ns1:PN_CREDIT_CARD_NUMBER>
            <ns1:PV_RETURN_EXTFIN_INFO>{ data($creditCardQuery/ns0:RETURN_EXTFIN_INFO) }</ns1:PV_RETURN_EXTFIN_INFO>
        </ns1:InputParameters>
};

declare variable $creditCardQuery as element(ns0:creditCardQuery) external;

xf:mcCONSSaldoTCGTIn($creditCardQuery)
