(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagodechequedegerenciaFCYResponse" element="ns0:PagodechequedegerenciaFCYResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/ConsultaUsuarioDelSistemaIn/";

declare function xf:ConsultaUsuarioDelSistemaIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $pagodechequedegerenciaFCYResponse as element(ns0:PagodechequedegerenciaFCYResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        let $result :=
                            for $INPUTTER in $pagodechequedegerenciaFCYResponse/TELLERType/gINPUTTER/INPUTTER
                            return
                                <criteriaValue>{ fn:tokenize(data($INPUTTER), "_")[2] }</criteriaValue>
                        return
                            $result[1]
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $pagodechequedegerenciaFCYResponse as element(ns0:PagodechequedegerenciaFCYResponse) external;

xf:ConsultaUsuarioDelSistemaIn($autenticacionRequestHeader,
    $pagodechequedegerenciaFCYResponse)