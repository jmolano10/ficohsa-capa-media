(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ConsultarTipoClienteExt/consultarTipoClienteExt_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTipoClienteExt";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/consultaTipoClienteIn/";

declare function xf:consultaTipoClienteIn($assetId as xs:string,
    $paymentType as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOID>{ $assetId }</ns0:PV_CODIGOID>
            <ns0:PV_MEDIOPAGO>{ $paymentType }</ns0:PV_MEDIOPAGO>
        </ns0:InputParameters>
};

declare variable $assetId as xs:string external;
declare variable $paymentType as xs:string external;

xf:consultaTipoClienteIn($assetId,
    $paymentType)