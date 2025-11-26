(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentasRequest" element="ns0:Transferenciaentrecuentas" location="../../xsds/Transferencias/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaentrecuentasResponse" element="ns0:TransferenciaentrecuentasResponse" location="../../xsds/Transferencias/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TransferenciaEntreCuentas/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($transferenciaentrecuentasRequest as element(ns0:Transferenciaentrecuentas),
    $transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $transferenciaentrecuentasRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $transferenciaentrecuentasResponse/FUNDSTRANSFERType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $transferenciaentrecuentasRequest as element(ns0:Transferenciaentrecuentas) external;
declare variable $transferenciaentrecuentasResponse as element(ns0:TransferenciaentrecuentasResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($transferenciaentrecuentasRequest,
    $transferenciaentrecuentasResponse)