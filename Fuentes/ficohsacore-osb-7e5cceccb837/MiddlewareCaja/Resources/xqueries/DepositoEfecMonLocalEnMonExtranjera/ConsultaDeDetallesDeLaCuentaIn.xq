(:: pragma bea:global-element-parameter parameter="$depositoEfectivoMLME" element="ns0:DepositoEfectivoMLME" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoEfectivoMLMEResponse" element="ns0:DepositoEfectivoMLMEResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoEfecMonLocalEnMonExtranjera/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($depositoEfectivoMLME as element(ns0:DepositoEfectivoMLME),
    $depositoEfectivoMLMEResponse as element(ns0:DepositoEfectivoMLMEResponse))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $depositoEfectivoMLME/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $ACCOUNT2 in $depositoEfectivoMLMEResponse/TELLERType/ACCOUNT2
                        return
                            <criteriaValue>{ data($ACCOUNT2) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $depositoEfectivoMLME as element(ns0:DepositoEfectivoMLME) external;
declare variable $depositoEfectivoMLMEResponse as element(ns0:DepositoEfectivoMLMEResponse) external;

xf:ConsultaDeDetallesDeLaCuentaIn($depositoEfectivoMLME,
    $depositoEfectivoMLMEResponse)