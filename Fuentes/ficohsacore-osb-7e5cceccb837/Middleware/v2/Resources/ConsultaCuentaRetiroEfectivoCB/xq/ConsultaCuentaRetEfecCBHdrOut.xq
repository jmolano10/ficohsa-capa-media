(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/ConsultaCuentaRetEfecCBHdrOut/";

declare function xf:ConsultaCuentaRetEfecCBHdrOut($successIndicator as xs:string,
    $messages as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $successIndicator }</successIndicator>
            <messages>{ $messages }</messages>
        </ns0:ResponseHeader>
};

declare variable $successIndicator as xs:string external;
declare variable $messages as xs:string external;

xf:ConsultaCuentaRetEfecCBHdrOut($successIndicator,
    $messages)