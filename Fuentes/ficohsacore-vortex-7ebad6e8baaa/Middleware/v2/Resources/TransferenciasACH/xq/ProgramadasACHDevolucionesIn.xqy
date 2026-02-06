xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TransferenciasACH/svcACHDevoluciones/xsd/svcACHDevoluciones_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/svcACHDevoluciones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProgramadasACHDevolucionesIn/";

declare function xf:ProgramadasACHDevolucionesIn($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest),
    $MensajeDevolucion as xs:string,
    $FTTransaccion as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_PARAM01>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</ns1:PV_PARAM01>
            <ns1:PV_PARAM02>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</ns1:PV_PARAM02>
            <ns1:PV_PARAM03>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</ns1:PV_PARAM03>
            <ns1:PV_PARAM04>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</ns1:PV_PARAM04>
            <ns1:PV_PARAM05>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</ns1:PV_PARAM05>
            <ns1:PV_PARAM06>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</ns1:PV_PARAM06>
            <ns1:PV_PARAM07>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</ns1:PV_PARAM07>
            <ns1:PV_PARAM08>{ data($transferenciasACHRequest1/LOCAL_ACCOUNT_TYPE) }</ns1:PV_PARAM08>
            <ns1:PV_PARAM09>{ data($transferenciasACHRequest1/LOCAL_ORIGINAL_ACCOUNT) }</ns1:PV_PARAM09>
            <ns1:PV_PARAM10>{ $MensajeDevolucion }</ns1:PV_PARAM10>
            <ns1:PV_PARAM11>{ $FTTransaccion }</ns1:PV_PARAM11>
        </ns1:InputParameters>
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;
declare variable $MensajeDevolucion as xs:string external;
declare variable $FTTransaccion as xs:string external;

xf:ProgramadasACHDevolucionesIn($transferenciasACHRequest1,
    $MensajeDevolucion,$FTTransaccion)