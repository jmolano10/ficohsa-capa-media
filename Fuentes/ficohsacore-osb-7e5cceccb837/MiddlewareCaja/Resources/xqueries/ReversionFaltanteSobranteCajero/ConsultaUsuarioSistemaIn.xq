(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reversionfaltosobrcajeroResponse" element="ns0:ReversionfaltosobrcajeroResponse" location="../../xsds/ReversaTransaccion2/XMLSchema_-704599497.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversionFaltanteSobranteCajero/ConsultaUsuarioSistemaIn/";

declare function xf:ConsultaUsuarioSistemaIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $reversionfaltosobrcajeroResponse as element(ns0:ReversionfaltosobrcajeroResponse))
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
                            for $INPUTTER in $reversionfaltosobrcajeroResponse/TELLERType/gINPUTTER/INPUTTER
                            return
                                <criteriaValue>{ data($INPUTTER) }</criteriaValue>
                        return
                            $result[1]
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $reversionfaltosobrcajeroResponse as element(ns0:ReversionfaltosobrcajeroResponse) external;

xf:ConsultaUsuarioSistemaIn($autenticacionRequestHeader,
    $reversionfaltosobrcajeroResponse)