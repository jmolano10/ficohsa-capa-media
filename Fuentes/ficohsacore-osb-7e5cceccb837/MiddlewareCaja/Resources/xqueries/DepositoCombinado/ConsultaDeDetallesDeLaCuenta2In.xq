(:: pragma bea:global-element-parameter parameter="$depositocombinado" element="ns0:Depositocombinado" location="../../xsds/DepositoCombinado/DepositoCombinado.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoCombinado/ConsultaDeDetallesDeLaCuenta2In/";

declare function xf:ConsultaDeDetallesDeLaCuenta2In($depositocombinado as element(ns0:Depositocombinado))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            <WebRequestCommon>
                <userName>{ data($depositocombinado/WebRequestCommon/userName) }</userName>
                <password>{ data($depositocombinado/WebRequestCommon/password) }</password>
            </WebRequestCommon>
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $SURROGATEAC in $depositocombinado/TELLERFINANCIALSERVICESFICOINPUTWSType/gTRANSACTION/mTRANSACTION[1]/SURROGATEAC
                        return
                            <criteriaValue>{ data($SURROGATEAC) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $depositocombinado as element(ns0:Depositocombinado) external;

xf:ConsultaDeDetallesDeLaCuenta2In($depositocombinado)