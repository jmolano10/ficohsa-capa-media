(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraRequest" element="ns0:Retirodeefecenmonextranjera" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraResponse" element="ns0:RetirodeefecenmonextranjeraResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeEfecEnMonExtranjera/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($retirodeefecenmonextranjeraRequest as element(ns0:Retirodeefecenmonextranjera),
    $retirodeefecenmonextranjeraResponse as element(ns0:RetirodeefecenmonextranjeraResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $retirodeefecenmonextranjeraRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $retirodeefecenmonextranjeraResponse/TELLERType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $retirodeefecenmonextranjeraRequest as element(ns0:Retirodeefecenmonextranjera) external;
declare variable $retirodeefecenmonextranjeraResponse as element(ns0:RetirodeefecenmonextranjeraResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($retirodeefecenmonextranjeraRequest,
    $retirodeefecenmonextranjeraResponse)