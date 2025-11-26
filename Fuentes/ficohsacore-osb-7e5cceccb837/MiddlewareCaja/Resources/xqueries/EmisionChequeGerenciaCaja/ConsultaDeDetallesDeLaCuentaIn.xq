(:: pragma bea:global-element-parameter parameter="$emisiondechqdegerenciaTT" element="ns0:EmisiondechqdegerenciaTT" location="../../xsds/EmisionChequeGerenciaCaja/EmisionChequeGerenciaCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaCaja/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($emisiondechqdegerenciaTT as element(ns0:EmisiondechqdegerenciaTT))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $emisiondechqdegerenciaTT/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $DebitAccountNo in $emisiondechqdegerenciaTT/FUNDSTRANSFERFICOCASHIERCHEQUEType/DebitAccountNo
                        return
                            <criteriaValue>{ data($DebitAccountNo) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $emisiondechqdegerenciaTT as element(ns0:EmisiondechqdegerenciaTT) external;

xf:ConsultaDeDetallesDeLaCuentaIn($emisiondechqdegerenciaTT)