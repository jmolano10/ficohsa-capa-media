xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TransferenciasACH/svcACHProgramadas/xsd/svnACHProgramadas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/svnACHProgramadas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProgramadasACHIn/";

declare function xf:ProgramadasACHIn($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest),
    $TransaccionFT as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_PARAM01>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</ns1:PV_PARAM01>
            <ns1:PV_PARAM02>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</ns1:PV_PARAM02>
            <ns1:PV_PARAM03>{ data($transferenciasACHRequest1/ACCOUNT_TYPE) }</ns1:PV_PARAM03>
            <ns1:PV_PARAM04>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</ns1:PV_PARAM04>
            <ns1:PV_PARAM05>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</ns1:PV_PARAM05>
            <ns1:PV_PARAM06>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</ns1:PV_PARAM06>
            <ns1:PV_PARAM07>{ data($transferenciasACHRequest1/BENEFICIARY_ID) }</ns1:PV_PARAM07>
            <ns1:PV_PARAM08>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</ns1:PV_PARAM08>
            <ns1:PV_PARAM09>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</ns1:PV_PARAM09>
            <ns1:PV_PARAM10>{ data($transferenciasACHRequest1/INTERFACE_REFERENCE_NO) }</ns1:PV_PARAM10>
            <ns1:PV_PARAM11>{ data($transferenciasACHRequest1/LOCAL_ACCOUNT_TYPE) }</ns1:PV_PARAM11>
            <ns1:PV_PARAM12>{ data($transferenciasACHRequest1/LOCAL_ORIGINAL_ACCOUNT) }</ns1:PV_PARAM12>
            <ns1:PV_PARAM13>{ $TransaccionFT }</ns1:PV_PARAM13>
        </ns1:InputParameters>
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;
declare variable $TransaccionFT as xs:string external;

xf:ProgramadasACHIn($transferenciasACHRequest1,
    $TransaccionFT)