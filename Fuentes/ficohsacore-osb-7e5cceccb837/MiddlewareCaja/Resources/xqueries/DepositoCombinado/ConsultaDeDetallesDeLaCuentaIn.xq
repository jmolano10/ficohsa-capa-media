(:: pragma bea:global-element-parameter parameter="$depositocombinadoRequest" element="ns0:Depositocombinado" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoCombinado/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($depositocombinadoRequest as element(ns0:Depositocombinado))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $depositocombinadoRequest/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $DepositAccount in $depositocombinadoRequest/TELLERFINANCIALSERVICESFICOINPUTWSType/DepositAccount
                        return
                            <criteriaValue>{ data($DepositAccount) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $depositocombinadoRequest as element(ns0:Depositocombinado) external;

xf:ConsultaDeDetallesDeLaCuentaIn($depositocombinadoRequest)