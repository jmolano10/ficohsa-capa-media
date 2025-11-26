(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAMDCResponse" element="ns0:pagoRecaudoAMDCResponse" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/ConsultaUsuarioSistemaIn/";

declare function xf:ConsultaUsuarioSistemaIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudoAMDCResponse as element(ns0:pagoRecaudoAMDCResponse))
    as element(ns1:Consultadeusuariosdelsistema) {
        <ns1:Consultadeusuariosdelsistema>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $INPUTTER in $pagoRecaudoAMDCResponse/INPUTTER
                        return
                            <criteriaValue>{ data($INPUTTER) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns1:Consultadeusuariosdelsistema>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAMDCResponse as element(ns0:pagoRecaudoAMDCResponse) external;

xf:ConsultaUsuarioSistemaIn($autenticacionRequestHeader,
    $pagoRecaudoAMDCResponse)