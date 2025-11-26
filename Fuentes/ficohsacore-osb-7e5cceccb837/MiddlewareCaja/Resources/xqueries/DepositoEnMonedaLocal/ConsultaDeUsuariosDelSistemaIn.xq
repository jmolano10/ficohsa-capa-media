(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedalocal" element="ns0:Depositoefecenmonedalocal" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedalocalResponse" element="ns0:DepositoefecenmonedalocalResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadeusuariosdelsistema" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoEnMonedaLocal/ConsultaDeUsuariosDelSistemaIn/";

declare function xf:ConsultaDeUsuariosDelSistemaIn($depositoefecenmonedalocal as element(ns0:Depositoefecenmonedalocal),
    $depositoefecenmonedalocalResponse as element(ns0:DepositoefecenmonedalocalResponse))
    as element(ns0:Consultadeusuariosdelsistema) {
        <ns0:Consultadeusuariosdelsistema>
            {
                for $WebRequestCommon in $depositoefecenmonedalocal/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSUSERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $AUTHORISER in $depositoefecenmonedalocalResponse/TELLERType/AUTHORISER
                        return
                            <criteriaValue>{ fn:tokenize(data($AUTHORISER), "_")[2] }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSUSERType>
        </ns0:Consultadeusuariosdelsistema>
};

declare variable $depositoefecenmonedalocal as element(ns0:Depositoefecenmonedalocal) external;
declare variable $depositoefecenmonedalocalResponse as element(ns0:DepositoefecenmonedalocalResponse) external;

xf:ConsultaDeUsuariosDelSistemaIn($depositoefecenmonedalocal,
    $depositoefecenmonedalocalResponse)