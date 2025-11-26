(:: pragma bea:global-element-parameter parameter="$accountQuery" element="ns0:accountQuery" location="../../xsd/AccountOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../BusinessServices/AbanksGT/ConsultaCuenta/xsd/MCConsultaCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/AccountOperationsTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsultaCuenta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/accountTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/AccountOperations/AccountQuery/xq/mcConsultaCuentaGTIn/";

declare function xf:mcConsultaCuentaGTIn($accountQuery as element(ns0:accountQuery))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            {
                let $ACCOUNT_REFERENCE := $accountQuery/ns0:ACCOUNT_REFERENCE
                return
                    <ns2:PR_ACCOUNT_REFERENCE>
                        <ns2:TYPE>{ data($ACCOUNT_REFERENCE/ns1:TYPE) }</ns2:TYPE>
                        <ns2:ID>{ data($ACCOUNT_REFERENCE/ns1:ID) }</ns2:ID>
                    </ns2:PR_ACCOUNT_REFERENCE>
            }
            <ns2:PV_SHOW_SIGNATURE>{ data($accountQuery/ns0:SHOW_SIGNATURE) }</ns2:PV_SHOW_SIGNATURE>
        </ns2:InputParameters>
};

declare variable $accountQuery as element(ns0:accountQuery) external;

xf:mcConsultaCuentaGTIn($accountQuery)
