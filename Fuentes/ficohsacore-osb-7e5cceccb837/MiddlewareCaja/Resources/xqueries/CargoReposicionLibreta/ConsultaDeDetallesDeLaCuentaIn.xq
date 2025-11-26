(:: pragma bea:global-element-parameter parameter="$cargoporreposicionlibreta" element="ns0:Cargoporreposicionlibreta" location="../../xsds/CargoReposicionLibreta/CargoReposicionLibreta.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallesdelacuenta" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/CargoReposicionLibreta/ConsultaDeDetallesDeLaCuentaIn/";

declare function xf:ConsultaDeDetallesDeLaCuentaIn($cargoporreposicionlibreta as element(ns0:Cargoporreposicionlibreta))
    as element(ns0:Consultadedetallesdelacuenta) {
        <ns0:Consultadedetallesdelacuenta>
            {
                for $WebRequestCommon in $cargoporreposicionlibreta/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSACCOUNTLISTType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $DEBITACCOUNT in $cargoporreposicionlibreta/ACCHARGEREQUESTFICOPBOOKCHQWSType/DEBITACCOUNT
                        return
                            <criteriaValue>{ data($DEBITACCOUNT) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSACCOUNTLISTType>
        </ns0:Consultadedetallesdelacuenta>
};

declare variable $cargoporreposicionlibreta as element(ns0:Cargoporreposicionlibreta) external;

xf:ConsultaDeDetallesDeLaCuentaIn($cargoporreposicionlibreta)