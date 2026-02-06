xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHOut/";

declare function xf:consultaTransaccionSwitchHOut($Message as xs:string,
    $Error as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>   
            <successIndicator>{ $Error }</successIndicator>
            <messages>{ $Message }</messages>
        </ns0:ResponseHeader>
};

declare variable $Message as xs:string external;
declare variable $Error as xs:string external;

xf:consultaTransaccionSwitchHOut($Message,
    $Error)