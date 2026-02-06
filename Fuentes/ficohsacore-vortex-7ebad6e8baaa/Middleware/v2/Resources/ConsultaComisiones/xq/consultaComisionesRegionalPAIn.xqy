xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns1:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABKPA/consultaComisionRegional/xsd/consultaComisionRegional_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionRegional";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesRegionalPAIn/";

declare function xf:consultaComisionesRegionalPAIn($consultaComisiones as element(ns1:consultaComisiones), $destinationCountry as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_MONEDA>{ data($consultaComisiones/SOURCE_CURRENCY) }</ns2:PV_MONEDA>
            <ns2:PN_CODIGOCLIENTE>{ data($consultaComisiones/CUSTOMER_ID) }</ns2:PN_CODIGOCLIENTE>                  
            <ns2:PV_CODIGOREGION>{$destinationCountry}</ns2:PV_CODIGOREGION>
        </ns2:InputParameters>
};

declare variable $consultaComisiones as element(ns1:consultaComisiones) external;
declare variable $destinationCountry as xs:string external;

xf:consultaComisionesRegionalPAIn($consultaComisiones, $destinationCountry)