(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalRequest" element="ns0:Retiroenmonedalocal" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalResponse" element="ns0:RetiroenmonedalocalResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroEnMonedaLocal/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($retiroenmonedalocalRequest as element(ns0:Retiroenmonedalocal),
    $retiroenmonedalocalResponse as element(ns0:RetiroenmonedalocalResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $retiroenmonedalocalRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $retiroenmonedalocalResponse/TELLERType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $retiroenmonedalocalRequest as element(ns0:Retiroenmonedalocal) external;
declare variable $retiroenmonedalocalResponse as element(ns0:RetiroenmonedalocalResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($retiroenmonedalocalRequest,
    $retiroenmonedalocalResponse)