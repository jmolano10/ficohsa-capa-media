<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalResponse" element="ns1:TransferenciaInternacionalResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaInternacionalResponse" location="transferenciaInternacionalType.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalOut/";

declare function xf:transferenciaInternacionalOut($transferenciaInternacionalResponse as element(ns1:TransferenciaInternacionalResponse))
    as element(ns0:transferenciaInternacionalResponse) {
        &lt;ns0:transferenciaInternacionalResponse>
        {
        	if (fn:string($transferenciaInternacionalResponse/Status/successIndicator/text()) = "Success") then (
                &lt;ORDERING_CUSTOMER>{ data($transferenciaInternacionalResponse/FUNDSTRANSFERType/gORDERINGCUST/ORDERINGCUST) }&lt;/ORDERING_CUSTOMER>
            
        	) else ()
        }
        &lt;/ns0:transferenciaInternacionalResponse>
};

declare variable $transferenciaInternacionalResponse as element(ns1:TransferenciaInternacionalResponse) external;

xf:transferenciaInternacionalOut($transferenciaInternacionalResponse)</con:xquery>
    <con:dependency location="../Resources/XMLSchema_1840876228.xsd">
        <con:schema ref="Middleware/Business_Resources/Transferencias/Resources/XMLSchema_1840876228"/>
    </con:dependency>
    <con:dependency location="transferenciaInternacionalType.xsd">
        <con:schema ref="Middleware/Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType"/>
    </con:dependency>
</con:xqueryEntry>