(:: pragma bea:global-element-parameter parameter="$depositodechequedegerencia" element="ns0:Depositodechequedegerencia" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($depositodechequedegerencia as element(ns0:Depositodechequedegerencia))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $depositodechequedegerencia/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $DepositAccount in $depositodechequedegerencia/TELLERFICOCASHIERCHEQUEDEPType/DepositAccount
                        return
                            <criteriaValue>{ data($DepositAccount) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $depositodechequedegerencia as element(ns0:Depositodechequedegerencia) external;

xf:ConsultaDeDetallesDeLaCuentaIn($depositodechequedegerencia)