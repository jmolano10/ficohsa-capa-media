(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../BusinessServices/MDW/consultarCorresponsalB/xsd/consultarCorresponsalB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Genericos/consultarCorresponsalBIn/";

declare function xf:consultarCorresponsalBIn($bankingCorrespId as xs:string,
    $sourceBank as xs:string,
    $transactionType as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGO_CORRESPONSAL>{ $bankingCorrespId }</ns0:PV_CODIGO_CORRESPONSAL>
            <ns0:PV_CODIGO_PAIS>{ $sourceBank }</ns0:PV_CODIGO_PAIS>
            <ns0:PV_CODIGO_TRANSACCION>{ $transactionType }</ns0:PV_CODIGO_TRANSACCION>
        </ns0:InputParameters>
};

declare variable $bankingCorrespId as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $transactionType as xs:string external;

xf:consultarCorresponsalBIn($bankingCorrespId,
    $sourceBank,
    $transactionType)