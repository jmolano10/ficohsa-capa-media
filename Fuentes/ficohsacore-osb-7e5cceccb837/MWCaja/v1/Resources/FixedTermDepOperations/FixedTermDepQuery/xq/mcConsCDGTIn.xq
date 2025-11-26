(:: pragma bea:global-element-parameter parameter="$fixedTermDepQuery" element="ns1:fixedTermDepQuery" location="../../xsd/FixedTermDepOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/AbanksGT/ConsultaDepositoPlazo/xsd/MCConsCD_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsCD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/fixedTermDepOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/FixedTermDepOperations/FixedTermDepQuery/xq/mcConsCDGTIn/";

declare function xf:mcConsCDGTIn($fixedTermDepQuery as element(ns1:fixedTermDepQuery))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_ACCOUNT_NUMBER>{ xs:decimal(data($fixedTermDepQuery/ns1:ACCOUNT_NUMBER)) }</ns0:PN_ACCOUNT_NUMBER>
        </ns0:InputParameters>
};

declare variable $fixedTermDepQuery as element(ns1:fixedTermDepQuery) external;

xf:mcConsCDGTIn($fixedTermDepQuery)
