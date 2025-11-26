(:: pragma bea:global-element-parameter parameter="$depositoefecenmonedaextranjera" element="ns0:Depositoefecenmonedaextranjera" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoDeEfecEnMonExtranjera/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($depositoefecenmonedaextranjera as element(ns0:Depositoefecenmonedaextranjera))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $depositoefecenmonedaextranjera/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $ACCOUNT in $depositoefecenmonedaextranjera/TELLERFICOHNANYCASHINFCYType/ACCOUNT
                        return
                            <criteriaValue>{ data($ACCOUNT) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $depositoefecenmonedaextranjera as element(ns0:Depositoefecenmonedaextranjera) external;

xf:ConsultaDeDetallesDeLaCuentaIn($depositoefecenmonedaextranjera)