xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH1" element="ns1:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjetas_v3/xsd/conDatoTarjetas_v3_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v3";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/conDatoTarjetas/";

declare function xf:conDatoTarjetas($validaProductoACH1 as element(ns1:validaProductoACH),
    $pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $pais }</ns0:Pais>
            <ns0:NumTarjeta>{ data($validaProductoACH1/PRODUCT_NUMBER) }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $validaProductoACH1 as element(ns1:validaProductoACH) external;
declare variable $pais as xs:string external;

xf:conDatoTarjetas($validaProductoACH1,
    $pais)