(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversarTransaccion" element="ns1:reversarTransaccion" location="../../xsds/ReversarTransaccion/ReversarTransaccion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ReversaTransaccion/ReversionRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_REVERSION_COBRANZA_ABANKS.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_INTEGRACION_CONVENIOS/REVERSION_COBRANZA_ABANKS/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionAbanksIn/";

declare function xf:ReversarTransaccionAbanksIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $reversarTransaccion as element(ns1:reversarTransaccion),
    $inputter as xs:string,
    $branchCode as xs:string,
    $valueDate as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:INPUTTER>{ $inputter }</ns0:INPUTTER>
            <ns0:BRANCH_CODE>{ $branchCode }</ns0:BRANCH_CODE>
            <ns0:TRANSACTION_ID>{ data($reversarTransaccion/TRANSACTION_ID) }</ns0:TRANSACTION_ID>
            <ns0:VALUE_DATE>{ $valueDate }</ns0:VALUE_DATE>
            <ns0:USERNAME>{ data($autenticacionRequestHeader/UserName) }</ns0:USERNAME>
            <ns0:PASSWORD>{ data($autenticacionRequestHeader/Password) }</ns0:PASSWORD>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $reversarTransaccion as element(ns1:reversarTransaccion) external;
declare variable $inputter as xs:string external;
declare variable $branchCode as xs:string external;
declare variable $valueDate as xs:string external;

xf:ReversarTransaccionAbanksIn($autenticacionRequestHeader,
    $reversarTransaccion,
    $inputter,
    $branchCode,
    $valueDate)