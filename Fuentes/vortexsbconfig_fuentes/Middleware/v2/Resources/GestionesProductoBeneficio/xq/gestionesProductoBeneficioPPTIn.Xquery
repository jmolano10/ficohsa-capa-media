<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ingresaBeneficio" element="ns1:ingresaProductoBeneficio" location="../xsd/gestionesProductoBeneficioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:creaCobranzaAutomatica" location="../../CreaCobranzaAutomatica/xsd/creaCobranzaAutomaticaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creaCobranzaAutomaticaTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesProductoBeneficioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesBeneficio/xq/gestionesProductoBeneficioPPTIn/";

declare function xf:gestionesProductoBeneficioPPTIn($ingresaBeneficio as element(ns1:ingresaProductoBeneficio),
    $branchcode as xs:string)
    as element(ns0:creaCobranzaAutomatica) {
        <ns0:creaCobranzaAutomatica>
            <ACCOUNT_NUMBER>{ data($ingresaBeneficio/PRODUCT/VALUE) }</ACCOUNT_NUMBER>
            <COLLECTION_CONTRACT>{ data($ingresaBeneficio/BENEFIT/VALUE) }</COLLECTION_CONTRACT>
            <USER_ID>{ data($ingresaBeneficio/USER_ID) }</USER_ID>
            <BRANCH_CODE>{ $branchcode }</BRANCH_CODE>
        </ns0:creaCobranzaAutomatica>
};

declare variable $ingresaBeneficio as element(ns1:ingresaProductoBeneficio) external;
declare variable $branchcode as xs:string external;

xf:gestionesProductoBeneficioPPTIn($ingresaBeneficio,
    $branchcode)]]></con:xquery>
    <con:dependency location="../xsd/gestionesProductoBeneficioTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesProductoBeneficio/xsd/gestionesProductoBeneficioTypes"/>
    </con:dependency>
    <con:dependency location="../../CreaCobranzaAutomatica/xsd/creaCobranzaAutomaticaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CreaCobranzaAutomatica/xsd/creaCobranzaAutomaticaTypes"/>
    </con:dependency>
</con:xqueryEntry>