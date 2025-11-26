(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedalocal" element="ns0:Depositoefecenmonedalocal" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoEnMonedaLocal/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($depositoefecenmonedalocal as element(ns0:Depositoefecenmonedalocal))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $depositoefecenmonedalocal/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $CreditAccount in $depositoefecenmonedalocal/TELLERFICOLCYCASHINType/CreditAccount
                        return
                            <criteriaValue>{ data($CreditAccount) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $depositoefecenmonedalocal as element(ns0:Depositoefecenmonedalocal) external;

xf:ConsultaDeDetallesDeLaCuentaIn($depositoefecenmonedalocal)