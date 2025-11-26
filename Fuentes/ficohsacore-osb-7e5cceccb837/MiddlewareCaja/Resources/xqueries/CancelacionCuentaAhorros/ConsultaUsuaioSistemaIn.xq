(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte2Response" element="ns0:Cancelaciondecuentaparte2Response" location="../../xsds/CancelacionCuenta/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CancelacionCuentaAhorros/ConsultaUsuaioSistemaIn/";

declare function xf:ConsultaUsuaioSistemaIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response))
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
                            for $INPUTTER in $cancelaciondecuentaparte2Response/TELLERType/gINPUTTER/INPUTTER/text()
                            return
                                <criteriaValue>{ fn-bea:fail-over(fn:tokenize(data($INPUTTER), "_")[2], $INPUTTER) }</criteriaValue>
                        return
                            $result[1]
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $cancelaciondecuentaparte2Response as element(ns0:Cancelaciondecuentaparte2Response) external;

xf:ConsultaUsuaioSistemaIn($autenticacionRequestHeader,
    $cancelaciondecuentaparte2Response)