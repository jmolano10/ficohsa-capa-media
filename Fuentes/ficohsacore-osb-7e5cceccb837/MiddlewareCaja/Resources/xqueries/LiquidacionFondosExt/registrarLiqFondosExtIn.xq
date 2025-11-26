(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/RegistrarLiqFondosExt/registrarLiqFondosExt_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarLiqFondosExt";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/registrarLiqFondosExtIn/";

declare function xf:registrarLiqFondosExtIn($assetId as xs:string,
    $txnReference as xs:string,
    $agency as xs:string,
    $user as xs:string,
    $paymentType as xs:string,
    $chequeNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOID>{ $assetId }</ns0:PV_CODIGOID>
            <ns0:PV_REFERENCIAPAGO>{ $txnReference }</ns0:PV_REFERENCIAPAGO>
            <ns0:PV_AGENCIA>{ $agency }</ns0:PV_AGENCIA>
            <ns0:PV_USUARIOPAGO>{ $user }</ns0:PV_USUARIOPAGO>
            <ns0:PV_TIPOPAGO>{ $paymentType }</ns0:PV_TIPOPAGO>
            <ns0:PV_NUMEROCHEQUE>{ $chequeNumber }</ns0:PV_NUMEROCHEQUE>
        </ns0:InputParameters>
};

declare variable $assetId as xs:string external;
declare variable $txnReference as xs:string external;
declare variable $agency as xs:string external;
declare variable $user as xs:string external;
declare variable $paymentType as xs:string external;
declare variable $chequeNumber as xs:string external;

xf:registrarLiqFondosExtIn($assetId,
    $txnReference,
    $agency,
    $user,
    $paymentType,
    $chequeNumber)