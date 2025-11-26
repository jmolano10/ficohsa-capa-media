(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../../xsds/ConsultaRecaudo/ConsultaRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetallecontratorecaudo" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudo/contratosConveniosIn/";

declare function xf:contratosConveniosIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudo as element(ns1:consultaRecaudo))
    as element(ns0:Consultadetallecontratorecaudo) {
        <ns0:Consultadetallecontratorecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSCOLLECTIONCONDSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaRecaudo/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCOLLECTIONCONDSType>
        </ns0:Consultadetallecontratorecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;

xf:contratosConveniosIn($autenticacionRequestHeader,
    $consultaRecaudo)