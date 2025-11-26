(:: pragma bea:global-element-parameter parameter="$consultaFondosExt1" element="ns1:consultaFondosExt" location="../../xsds/LiquidacionFondosExt/LiquidacionFondosExt.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ConsultarLiqFondosExt/consultarLiqFondosExt_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLiqFondosExt";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidacionFondosExtTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/consultaLiqFondosIn/";

declare function xf:consultaLiqFondosIn($assetId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CODIGOID>{ $assetId }</ns0:PV_CODIGOID>
        </ns0:InputParameters>
};

declare variable $assetId as xs:string external;

xf:consultaLiqFondosIn($assetId)