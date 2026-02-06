xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Autenticacion/xq/validacionINTNHeaderOUT/";

declare function xf:validacionINTNHeaderOUT($errorMessage as xs:string,
    $successIndicator as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $successIndicator }</successIndicator>
            {
           if($successIndicator="ERROR") then (
            <messages>{ $errorMessage }</messages>
              )
           else()
          }
        </ns0:ResponseHeader>
};

declare variable $errorMessage as xs:string external;
declare variable $successIndicator as xs:string external;

xf:validacionINTNHeaderOUT($errorMessage,
    $successIndicator)