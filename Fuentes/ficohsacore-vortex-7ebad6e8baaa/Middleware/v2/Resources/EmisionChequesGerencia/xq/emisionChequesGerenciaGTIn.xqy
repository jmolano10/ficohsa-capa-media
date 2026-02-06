xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$emisionChequesGerencia" element="ns1:emisionChequesGerencia" location="../../../../Business_Resources/emisionChequesGerencia/emisionChequesGerenciaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/emisionChequesGerencia/xsd/emisionChequesGerencia_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/emisionChequesGerencia";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/EmisionChequesGerenciaGTIn/";

declare function xf:EmisionChequesGerenciaGTIn($emisionChequesGerencia as element(ns1:emisionChequesGerencia))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:DEBIT_ACCOUNT>{ data($emisionChequesGerencia/DEBIT_ACCOUNT) }</ns0:DEBIT_ACCOUNT>
            <ns0:BENEFICIARY_NAME>{ data($emisionChequesGerencia/BENEFICIARY_NAME) }</ns0:BENEFICIARY_NAME>
            <ns0:AMOUNT>{ data($emisionChequesGerencia/AMOUNT) }</ns0:AMOUNT>
            <ns0:DESCRIPTION>{ data($emisionChequesGerencia/DESCRIPTION) }</ns0:DESCRIPTION>
            <ns0:WITHDRAWAL_BRANCH_ID>{ data($emisionChequesGerencia/WITHDRAWAL_BRANCH_ID) }</ns0:WITHDRAWAL_BRANCH_ID>
            <ns0:INTERFACE_REFERENCE_NO>{ data($emisionChequesGerencia/INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
        </ns0:InputParameters>
};

declare variable $emisionChequesGerencia as element(ns1:emisionChequesGerencia) external;

xf:EmisionChequesGerenciaGTIn($emisionChequesGerencia)