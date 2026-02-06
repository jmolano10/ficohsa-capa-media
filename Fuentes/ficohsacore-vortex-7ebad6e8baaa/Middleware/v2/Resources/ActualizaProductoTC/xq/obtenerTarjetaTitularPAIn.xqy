xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaProductoTC1" element="ns0:actualizaProductoTC" location="../xsd/actualizaProductoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataPA/obtenerTarjetaTitular/xsd/obtenerTarjetaTitular_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaProductoTCTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTarjetaTitular";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProductoTC/xq/obtenerTarjetaTitularPAIn/";

declare function xf:obtenerTarjetaTitularPAIn($actualizaProductoTC1 as element(ns0:actualizaProductoTC),$countryCode)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ data($countryCode) }</ns1:Pais>
            <ns1:Numero>{ string($actualizaProductoTC1/ACCOUNT_NUMBER/text()) }</ns1:Numero>
            <ns1:Tipo>0</ns1:Tipo>
        </ns1:InputParameters>
};

declare variable $actualizaProductoTC1 as element(ns0:actualizaProductoTC) external;
declare variable $countryCode as xs:string external;

xf:obtenerTarjetaTitularPAIn($actualizaProductoTC1,$countryCode)