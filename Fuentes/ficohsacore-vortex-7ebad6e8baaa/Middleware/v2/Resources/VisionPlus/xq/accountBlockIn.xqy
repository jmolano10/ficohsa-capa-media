xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueoCTA" element="ns0:bloqueoCTA" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/MasterData/conDatoCuenta/xsd/conDatoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AccountBlockRequest" location="../../../BusinessServices/VisionPlus/fdcs/wsdl/Fdcs.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoCuenta";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoCTA/xq/accountBlockIn/";

declare function xf:accountBlockIn($orgNumber as xs:string,
    $accoutNumber as xs:string,
    $blockCode as xs:string,
    $blockCodeIndicator as xs:string,
    $foreignUse as xs:string)
    as element(ns1:AccountBlockRequest) {
        <ns1:AccountBlockRequest>
            <OrgNumber>{ data($orgNumber) }</OrgNumber>           
            <AccountNumber>{ data($accoutNumber) }</AccountNumber>
            <BlockCode>{ data($blockCode) }</BlockCode>
            <BlockCodeIndicator>{ data($blockCodeIndicator) }</BlockCodeIndicator>
            <ForeignUse>{  data($foreignUse) }</ForeignUse>
        </ns1:AccountBlockRequest>
};

declare variable $orgNumber as xs:string external;
declare variable $accoutNumber as xs:string external;
declare variable $blockCode as xs:string external;
declare variable $blockCodeIndicator as xs:string external;
declare variable $foreignUse as xs:string external;

xf:accountBlockIn($orgNumber,
    $accoutNumber,
    $blockCode,
    $blockCodeIndicator,
    $foreignUse)