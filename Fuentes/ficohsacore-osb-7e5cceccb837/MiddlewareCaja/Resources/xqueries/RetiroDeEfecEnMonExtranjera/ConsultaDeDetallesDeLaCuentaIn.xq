(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraRequest" element="ns0:Retirodeefecenmonextranjera" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraResponse" element="ns0:RetirodeefecenmonextranjeraResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeEfecEnMonExtranjera/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($retirodeefecenmonextranjeraRequest as element(ns0:Retirodeefecenmonextranjera),
    $retirodeefecenmonextranjeraResponse as element(ns0:RetirodeefecenmonextranjeraResponse))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $retirodeefecenmonextranjeraRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $ACCOUNT2 in $retirodeefecenmonextranjeraResponse/TELLERType/ACCOUNT2
                        return
                            <criteriaValue>{ data($ACCOUNT2) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $retirodeefecenmonextranjeraRequest as element(ns0:Retirodeefecenmonextranjera) external;
declare variable $retirodeefecenmonextranjeraResponse as element(ns0:RetirodeefecenmonextranjeraResponse) external;

xf:ConsultaDeDetallesDeLaCuentaIn($retirodeefecenmonextranjeraRequest,
    $retirodeefecenmonextranjeraResponse)