(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns1:consultaGeneralPrestamo" location="../../xsds/ConsultaGeneralPrestamo/ConsultaGeneralPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadesaldodeprestamo" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaGeneralPrestamo/ConsultaPrestamoT24In/";

declare function xf:ConsultaPrestamoT24In($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo))
    as element(ns0:Consultadesaldodeprestamo) {
        <ns0:Consultadesaldodeprestamo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader1/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader1/Password) }</password>
            </WebRequestCommon>
            <WSLOANDETAILSAAType>
                <enquiryInputCollection>
                    <columnName>ARRANGEMENT.ID</columnName>
                    <criteriaValue>{ fn:upper-case(data($consultaGeneralPrestamo1/LOAN_ID)) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLOANDETAILSAAType>
        </ns0:Consultadesaldodeprestamo>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaGeneralPrestamo1 as element(ns1:consultaGeneralPrestamo) external;

xf:ConsultaPrestamoT24In($autenticacionRequestHeader1,
    $consultaGeneralPrestamo1)