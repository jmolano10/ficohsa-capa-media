(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAMDC" element="ns0:pagoRecaudoAMDC" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadetallecontratorecaudo" location="../../xsds/ContratosConvenios/XMLSchema_266061745.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/ConsultaContratoIn/";

declare function xf:ConsultaContratoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC))
    as element(ns1:Consultadetallecontratorecaudo) {
        <ns1:Consultadetallecontratorecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSCOLLECTIONCONDSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($pagoRecaudoAMDC/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCOLLECTIONCONDSType>
        </ns1:Consultadetallecontratorecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC) external;

xf:ConsultaContratoIn($autenticacionRequestHeader,
    $pagoRecaudoAMDC)