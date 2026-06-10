<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$actualizaProductosCliente" element="ns0:actualizaProductosCliente" location="../xsd/actualizaProductosClienteTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProductosCliente/xq/actualizaProductosIN/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaProductosClienteTypes";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.sites";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns6 = "urn:infocorp.framework.common";


declare function xf:actualizaProductosIN($actualizaProductosCliente as element(ns0:actualizaProductosCliente))
    as element(*) {
        &lt;ns3:SynchronizeNewSiteProductsOnDemandMessageIn>
			&lt;ns3:DocumentNumber>{ data($actualizaProductosCliente/CUSTOMER_ID_VALUE) }&lt;/ns3:DocumentNumber>
      	&lt;/ns3:SynchronizeNewSiteProductsOnDemandMessageIn>
};

declare variable $actualizaProductosCliente as element(ns0:actualizaProductosCliente) external;

xf:actualizaProductosIN($actualizaProductosCliente)</con:xquery>
    <con:dependency location="../xsd/actualizaProductosClienteTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ActualizaProductosCliente/xsd/actualizaProductosClienteTypes"/>
    </con:dependency>
</con:xqueryEntry>