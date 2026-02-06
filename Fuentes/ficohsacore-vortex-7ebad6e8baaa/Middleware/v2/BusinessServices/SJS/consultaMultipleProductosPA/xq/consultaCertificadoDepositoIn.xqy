xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ABKPA/consultaCertificadoDeposito/xsd/consultaCertificadoDeposito_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCertificadoDeposito";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaCertificadoDepositoIn/";

declare function xf:consultaCertificadoDepositoIn($ID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:DEPOSIT_NUMBER>{ $ID }</ns0:DEPOSIT_NUMBER>
        </ns0:InputParameters>
};

declare variable $ID as xs:string external;

xf:consultaCertificadoDepositoIn($ID)