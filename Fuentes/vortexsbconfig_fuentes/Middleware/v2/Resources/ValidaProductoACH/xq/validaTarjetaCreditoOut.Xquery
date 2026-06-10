<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns1:consultaDatosTarjetaCreditoResponse" location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoACHResponse" location="../xsd/validaProductoACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaTarjetaCreditoOut/";

declare function xf:validaTarjetaCreditoOut($validaProductoACH as element(ns0:validaProductoACH),
    $consultaDatosTarjetaCreditoResponse as element(ns1:consultaDatosTarjetaCreditoResponse),
    $CardNumber as xs:string,
    $CardHolderName as xs:string)
    as element(ns0:validaProductoACHResponse) {
        <ns0:validaProductoACHResponse>
            <PRODUCT_NUMBER>{ $CardNumber }</PRODUCT_NUMBER>
            <PRODUCT_NAME>
            { 
                            let $First  := (substring(data($CardHolderName),1,3))  
                            let $Last  := (substring(data($CardHolderName), string-length(data($CardHolderName)) - 3 + 1, 3))  
                            return
                                if (data($CardHolderName) = '') then
                                    ('')
                                else 
                                    string-join(($First,$Last),'**********') 
            }
            </PRODUCT_NAME>
            <PRODUCT_STATUS>true</PRODUCT_STATUS>
            <UUID>{ data($validaProductoACH/UUID) }</UUID>
            {
                for $KV_PAIRS in $validaProductoACH/KV_PAIRS
                return
                    <KV_PAIRS>{ $KV_PAIRS/@* , $KV_PAIRS/node() }</KV_PAIRS>
            }
        </ns0:validaProductoACHResponse>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;
declare variable $consultaDatosTarjetaCreditoResponse as element(ns1:consultaDatosTarjetaCreditoResponse) external;
declare variable $CardNumber as xs:string external;
declare variable $CardHolderName as xs:string external;

xf:validaTarjetaCreditoOut($validaProductoACH,
    $consultaDatosTarjetaCreditoResponse,
    $CardNumber,
    $CardHolderName)]]></con:xquery>
    <con:dependency location="../xsd/validaProductoACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaProductoACH/xsd/validaProductoACHTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xsd/consultaDatosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>