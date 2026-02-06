xquery version "2004-draft";
(:: pragma bea:schema-type-parameter parameter="$group" type="ns0:GROUP" location="../../../../Resources/ConsultaSituacionFinanciera/xsd/sjConsultaSituacionFinancieraInterno.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaSituacionFinancieraSolicitud" location="../../../CTS/consultaSituacionFinanciera/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSituacionFinancieraInterno";
declare namespace ns2 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoNI/xq/sjConsultaSituacionFinancieraCTSIn/";

declare function xf:sjConsultaSituacionFinancieraCTSIn($group as element())
    as element(ns2:opConsultaSituacionFinancieraSolicitud) {
        <ns2:opConsultaSituacionFinancieraSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:canal>1</ns1:canal>
            <ns1:clientes>{ fn:string-join(data($group/CUSTOMERS/CUSTOMER/ID),',') }</ns1:clientes>
            <ns1:tipoProductos>{ fn:string-join(data($group/CUSTOMERS/CUSTOMER/PRODUCT_TYPE),',') }</ns1:tipoProductos>
            <ns1:tipos>{ fn:string-join(data($group/PRODUCTS/PRODUCT/TYPE),',') }</ns1:tipos>
            <ns1:idProductos>{ fn:string-join(data($group/PRODUCTS/PRODUCT/ID),',') }</ns1:idProductos>


        </ns2:opConsultaSituacionFinancieraSolicitud>
};

declare variable $group as element() external;

xf:sjConsultaSituacionFinancieraCTSIn($group)