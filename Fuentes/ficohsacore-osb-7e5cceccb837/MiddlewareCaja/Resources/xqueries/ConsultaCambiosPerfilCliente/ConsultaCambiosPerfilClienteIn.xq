(:: pragma bea:global-element-parameter parameter="$consultaperfildecliente" element="ns0:Consultaperfildecliente" location="../../xsds/ConsultaCambiosPerfilCliente/ConsultaCambiosPerfilCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaperfildecliente" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCambiosPerfilCliente/ConsultaCambiosPerfilClienteIn/";

declare function xf:ConsultaCambiosPerfilClienteIn($consultaperfildecliente as element(ns0:Consultaperfildecliente))
    as element(ns0:Consultaperfildecliente) {
        $consultaperfildecliente
};

declare variable $consultaperfildecliente as element(ns0:Consultaperfildecliente) external;

xf:ConsultaCambiosPerfilClienteIn($consultaperfildecliente)