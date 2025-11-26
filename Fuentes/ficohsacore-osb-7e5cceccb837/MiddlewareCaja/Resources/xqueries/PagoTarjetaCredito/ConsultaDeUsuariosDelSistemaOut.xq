(:: pragma bea:global-element-parameter parameter="$consultadeusuariosdelsistemaResponse" element="ns0:ConsultadeusuariosdelsistemaResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoCombinado/ConsultaDeUsuariosDelSistemaOut/";

declare function xf:ConsultaDeUsuariosDelSistemaOut($consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse))
    as xs:string {
        fn:string($consultadeusuariosdelsistemaResponse/WSUSERType[1]/gWSUSERDetailType/mWSUSERDetailType[1]/BRANCHNAME/text())
};

declare variable $consultadeusuariosdelsistemaResponse as element(ns0:ConsultadeusuariosdelsistemaResponse) external;

xf:ConsultaDeUsuariosDelSistemaOut($consultadeusuariosdelsistemaResponse)