(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultiple" element="ns1:consultaRecaudoMultiple" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetallecontratorecaudo" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/ConsultaDetalleContratoRecaudoIn/";

declare function xf:ConsultaDetalleContratoRecaudoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoMultiple as element(ns1:consultaRecaudoMultiple))
    as element(ns0:Consultadetallecontratorecaudo) {
        <ns0:Consultadetallecontratorecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSCOLLECTIONCONDSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaRecaudoMultiple/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCOLLECTIONCONDSType>
        </ns0:Consultadetallecontratorecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoMultiple as element(ns1:consultaRecaudoMultiple) external;

xf:ConsultaDetalleContratoRecaudoIn($autenticacionRequestHeader,
    $consultaRecaudoMultiple)