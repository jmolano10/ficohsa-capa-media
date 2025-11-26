(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeparametroscore" location="../../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksConsultaParamsCore/";

declare function xf:pagoRecaudoAbanksConsultaParamsCore($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns0:Consultadeparametroscore) {
        <ns0:Consultadeparametroscore>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader1/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader1/Password) }</password>
            </WebRequestCommon>
            <WSCOREPARAMETERSType>
                <enquiryInputCollection>
                    <columnName>CURRENCY.CODE</columnName>
                    <criteriaValue>USD</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCOREPARAMETERSType>
        </ns0:Consultadeparametroscore>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:pagoRecaudoAbanksConsultaParamsCore($autenticacionRequestHeader1)