(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalRequest" element="ns0:Retiroenmonedalocal" location="../../xsds/RetiroEnMonedaLocal/RetiroEnMonedaLocal.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($retiroenmonedalocalRequest as element(ns0:Retiroenmonedalocal))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $retiroenmonedalocalRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $ACCOUNT2 in $retiroenmonedalocalRequest/TELLERFICOLCYCASHWDLWSType/ACCOUNT2
                        return
                            <criteriaValue>{ data($ACCOUNT2) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $retiroenmonedalocalRequest as element(ns0:Retiroenmonedalocal) external;

xf:ConsultaDeDetallesDeLaCuentaIn($retiroenmonedalocalRequest)