(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/ConsultaDepositoPlazo/xsd/MCConsCD_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:fixedTermDepQueryResponse" location="../../xsd/FixedTermDepOperationsTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsCD";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/accountTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/fixedTermDepOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/FixedTermDepOperations/FixedTermDepQuery/xq/fixedTermDepQueryGTOut/";

declare function xf:fixedTermDepQueryGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:fixedTermDepQueryResponse) {
        <ns1:fixedTermDepQueryResponse>
            {
                for $PR_ACCOUNT_INFO in $outputParameters/ns0:PR_ACCOUNT_INFO
                return
                    <ns1:ACCOUNT_INFO>
                        <ns2:NUMBER>{ data($PR_ACCOUNT_INFO/ns0:NUMBERS) }</ns2:NUMBER>
                        <ns2:NAME>{ data($PR_ACCOUNT_INFO/ns0:NAME) }</ns2:NAME>
                        <ns2:CURRENCY>{ data($PR_ACCOUNT_INFO/ns0:CURRENCY) }</ns2:CURRENCY>
                        <ns2:TYPE>{ data($PR_ACCOUNT_INFO/ns0:TYPE) }</ns2:TYPE>
                        <ns2:STATUS>{ data($PR_ACCOUNT_INFO/ns0:STATUS) }</ns2:STATUS>
                    </ns1:ACCOUNT_INFO>
            }
        </ns1:fixedTermDepQueryResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:fixedTermDepQueryGTOut($outputParameters)
