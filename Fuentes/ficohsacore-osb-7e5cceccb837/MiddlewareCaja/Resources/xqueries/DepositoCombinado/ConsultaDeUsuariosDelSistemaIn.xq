(:: pragma bea:global-element-parameter parameter="$depositocombinadoRequest" element="ns0:Depositocombinado" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositocombinadoResponse" element="ns0:DepositocombinadoResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoCombinado/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($depositocombinadoRequest as element(ns0:Depositocombinado),
    $depositocombinadoResponse as element(ns0:DepositocombinadoResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $depositocombinadoRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $depositocombinadoResponse/TELLERFINANCIALSERVICESType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $depositocombinadoRequest as element(ns0:Depositocombinado) external;
declare variable $depositocombinadoResponse as element(ns0:DepositocombinadoResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($depositocombinadoRequest,
    $depositocombinadoResponse)